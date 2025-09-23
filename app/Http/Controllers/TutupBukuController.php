<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BukuKas;
use App\Models\SaldoBulanan;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TutupBukuController extends Controller
{
    /**
     * Menampilkan halaman konfirmasi untuk proses tutup buku.
     */
    public function index()
    {
        // 1. Tentukan periode terakhir yang sudah ditutup
        $saldoTerakhir = SaldoBulanan::latest('periode')->first();
        
        // 2. Tentukan periode saat ini yang akan ditutup
        if ($saldoTerakhir) {
            $periodeSaatIni = Carbon::parse($saldoTerakhir->periode)->addMonth()->startOfMonth();
            $saldoAwal = $saldoTerakhir->saldo_akhir;
        } else {
            // Jika belum pernah ada tutup buku, mulai dari transaksi paling awal
            $transaksiPertama = BukuKas::orderBy('tanggal', 'asc')->first();
            if (!$transaksiPertama) {
                return view('pages.tutup-buku.index')->with('pesan', 'Tidak ada transaksi untuk diproses.');
            }
            $periodeSaatIni = Carbon::parse($transaksiPertama->tanggal)->startOfMonth();
            $saldoAwal = 0;
        }

        // Jangan proses bulan saat ini, hanya bulan yang sudah lewat
        if ($periodeSaatIni->isSameMonth(Carbon::now())) {
            return view('pages.tutup-buku.index')->with('pesan', 'Anda belum bisa menutup buku untuk bulan yang sedang berjalan.');
        }

        // 3. Hitung total transaksi untuk periode saat ini
        $startDate = $periodeSaatIni->copy()->startOfMonth();
        $endDate = $periodeSaatIni->copy()->endOfMonth();

        $totalPemasukan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $saldoAwal + $totalPemasukan - $totalPengeluaran;

        $data = [
            'periode' => $periodeSaatIni,
            'saldoAwal' => $saldoAwal,
            'totalPemasukan' => $totalPemasukan,
            'totalPengeluaran' => $totalPengeluaran,
            'saldoAkhir' => $saldoAkhir,
        ];

        return view('pages.tutup-buku.index', $data);
    }

    /**
     * Memproses dan menyimpan data tutup buku.
     */
    public function store(Request $request)
    {
        $request->validate([
            'periode' => 'required|date',
            'saldo_awal' => 'required|numeric',
            'total_pemasukan' => 'required|numeric',
            'total_pengeluaran' => 'required|numeric',
            'saldo_akhir' => 'required|numeric',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $periode = Carbon::parse($request->periode)->startOfMonth();

                $exists = SaldoBulanan::where('periode', $periode)->exists();
                if ($exists) {
                    throw new \Exception('Periode ini sudah pernah ditutup sebelumnya.');
                }
                
                SaldoBulanan::create([
                    'periode' => $periode,
                    'saldo_awal' => $request->saldo_awal,
                    'total_pemasukan' => $request->total_pemasukan,
                    'total_pengeluaran' => $request->total_pengeluaran,
                    'saldo_akhir' => $request->saldo_akhir,
                    'ditutup_pada' => now(),
                    'ditutup_oleh' => Auth::id(),
                ]);
            });
        } catch (\Exception $e) {
            return redirect()->route('tutup-buku.index')->with('error', 'Gagal memproses tutup buku: ' . $e->getMessage());
        }

        return redirect()->route('tutup-buku.index')->with('success', 'Tutup buku untuk periode ' . Carbon::parse($request->periode)->isoFormat('MMMM YYYY') . ' berhasil.');
    }
}