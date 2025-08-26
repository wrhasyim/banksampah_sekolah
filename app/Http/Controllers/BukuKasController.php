<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Exports\BukuKasExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;

class BukuKasController extends Controller
{
    /**
     * Menampilkan daftar transaksi kas dengan paginasi dan filter.
     */
    public function index(Request $request)
    {
        $query = BukuKas::with(['admin', 'kategori'])->latest('tanggal');

        // Fitur Filter Berdasarkan Rentang Tanggal
        if ($request->filled('start_date') && $request->filled('end_date')) {
            $startDate = Carbon::parse($request->start_date)->startOfDay();
            $endDate = Carbon::parse($request->end_date)->endOfDay();
            $query->whereBetween('tanggal', [$startDate, $endDate]);
        }

        // Ambil data dengan Paginasi
        $transaksi = $query->paginate(15);

        // Kalkulasi total pemasukan dan pengeluaran untuk saldo akhir
        $pemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $pemasukan - $pengeluaran;
        
        // Ambil semua data kategori untuk form dropdown
        $kategori = KategoriTransaksi::all();

        // Logika untuk menghitung saldo berjalan (Running Balance)
        $saldoBerjalan = 0;
        $transaksi->getCollection()->transform(function ($trx) use (&$saldoBerjalan) {
            if ($trx->tipe == 'pemasukan') {
                $saldoBerjalan += $trx->jumlah;
            } else {
                $saldoBerjalan -= $trx->jumlah;
            }
            $trx->saldo_berjalan = $saldoBerjalan;
            return $trx;
        });

        return view('pages.buku-kas.index', compact('transaksi', 'saldoAkhir', 'kategori'));
    }

    public function exportExcel(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        $fileName = 'laporan-buku-kas-' . Carbon::now()->format('Y-m-d') . '.xlsx';
        return Excel::download(new BukuKasExport($startDate, $endDate), $fileName);
    }

    public function exportPdf(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        $query = BukuKas::with('kategori')->latest('tanggal');
        if ($startDate && $endDate) {
            $query->whereBetween('tanggal', [$startDate, $endDate]);
        }
        $transaksi = $query->get();
        $totalPemasukan = $transaksi->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = $transaksi->where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;
        $pdf = Pdf::loadView('pages.buku-kas.buku-kas-pdf', compact(
            'transaksi', 'startDate', 'endDate', 
            'totalPemasukan', 'totalPengeluaran', 'saldoAkhir'
        ));
        $fileName = 'laporan-buku-kas-' . Carbon::now()->format('Y-m-d') . '.pdf';
        return $pdf->download($fileName);
    }

    /**
     * Menyimpan transaksi baru ke database.
     */
    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'jumlah' => 'required|numeric|min:1',
            'id_kategori' => 'required|exists:kategori_transaksi,id', // Diubah menjadi required
        ]);

        $kategori = KategoriTransaksi::findOrFail($request->id_kategori);

        BukuKas::create([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi,
            'tipe' => $kategori->tipe, // Tipe diambil dari kategori
            'jumlah' => $request->jumlah,
            'id_kategori' => $request->id_kategori,
            'id_admin' => Auth::id()
        ]);

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi kas berhasil dicatat!');
    }

    /**
     * Menampilkan form untuk mengedit transaksi.
     */
    public function edit(BukuKas $bukuKa)
    {
        $kategori = KategoriTransaksi::all();
        return view('pages.buku-kas.edit', compact('bukuKa', 'kategori'));
    }

    /**
     * Memperbarui data transaksi di database.
     */
    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'jumlah' => 'required|numeric|min:1',
            'id_kategori' => 'required|exists:kategori_transaksi,id', // Diubah menjadi required
        ]);

        $kategori = KategoriTransaksi::findOrFail($request->id_kategori);

        $bukuKa->update([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi,
            'tipe' => $kategori->tipe, // Tipe diambil dari kategori
            'jumlah' => $request->jumlah,
            'id_kategori' => $request->id_kategori,
        ]);

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil diperbarui!');
    }

    /**
     * Menghapus transaksi (menggunakan Soft Delete).
     */
    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }
}