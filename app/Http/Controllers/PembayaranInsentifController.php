<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\PembayaranInsentif;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class PembayaranInsentifController extends Controller
{
    /**
     * Menampilkan halaman rekapitulasi dan formulir pembayaran insentif.
     */
    public function index()
    {
        $insentifPerKelas = Insentif::where('status_pembayaran', 'belum dibayar')
            ->with('kelas.waliKelas')
            ->select('kelas_id', DB::raw('SUM(jumlah_insentif) as total_insentif'))
            ->groupBy('kelas_id')
            ->get();

        return view('pages.insentif.pembayaran', compact('insentifPerKelas'));
    }

    /**
     * Menyimpan data pembayaran insentif.
     */
    public function store(Request $request)
    {
        $request->validate([
            'pembayaran' => 'required|array|min:1',
            'pembayaran.*.kelas_id' => 'required|exists:kelas,id',
            'pembayaran.*.jumlah' => 'required|numeric|min:1',
        ]);

        DB::transaction(function () use ($request) {
            foreach ($request->pembayaran as $bayar) {
                $kelasId = $bayar['kelas_id'];
                $jumlahDibayar = $bayar['jumlah'];
                
                // ===== PERUBAHAN 1: Memuat relasi 'waliKelas' saja =====
                $kelas = Kelas::with('waliKelas')->find($kelasId);

                if (!$kelas || !$kelas->waliKelas) {
                    // Lompati jika kelas atau wali kelas tidak ditemukan
                    continue;
                }

                // 1. Buat catatan riwayat pembayaran
                $pembayaran = PembayaranInsentif::create([
                    'id_admin' => Auth::id(),
                    'id_wali_kelas' => $kelas->id_wali_kelas,
                    'tanggal_pembayaran' => now(),
                      'total_dibayar' => $jumlahDibayar, // <-- UBAH NAMA KOLOM DI SINI
                ]);

                // 2. Catat sebagai pengeluaran di Buku Kas
                BukuKas::create([
                    'tanggal' => now(),
                    // ===== PERUBAHAN 2: Akses nama_lengkap langsung dari waliKelas =====
                    'deskripsi' => 'Pembayaran Insentif Wali Kelas: ' . ($kelas->waliKelas->nama_lengkap ?? 'N/A'),
                    'tipe' => 'pengeluaran',
                    'jumlah' => $jumlahDibayar,
                    'id_admin' => Auth::id(),
                ]);

                // 3. Update status semua insentif yang terkait
                Insentif::where('kelas_id', $kelasId)
                    ->where('status_pembayaran', 'belum dibayar')
                    ->update([
                        'status_pembayaran' => 'sudah dibayar',
                        'pembayaran_insentif_id' => $pembayaran->id,
                    ]);
            }
        });

        return redirect()->route('insentif.index')->with('success', 'Pembayaran insentif berhasil dicatat.');
    }
}