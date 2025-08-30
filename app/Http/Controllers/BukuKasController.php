<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use Illuminate\Http\Request;
use App\Exports\BukuKasExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use App\Models\KategoriTransaksi;
use Illuminate\Support\Facades\Auth; // <-- Pastikan ini di-import
use Illuminate\Support\Facades\DB;

class BukuKasController extends Controller
{
    public function index(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        // Mengambil data berdasarkan rentang tanggal yang dipilih
        $bukuKas = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
            ->orderBy('tanggal', 'asc')
            ->get();

        // Menghitung saldo akhir berdasarkan SEMUA transaksi, bukan hanya bulan yang difilter
        $totalPemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;
        
        $kategori = KategoriTransaksi::all();

        return view('pages.buku-kas.index', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'kategori'));
    }

    public function store(Request $request)
    {
        // --- PERBAIKAN DI SINI ---
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255', // Diubah dari 'keterangan'
            'jumlah' => 'required|numeric|min:0',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
        ]);

        BukuKas::create([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi, // Diubah dari 'keterangan'
            'jumlah' => $request->jumlah,
            'tipe' => $request->tipe,
            'id_kategori' => $request->id_kategori,
            'id_admin' => Auth::id(), // Menambahkan id_admin saat membuat manual
        ]);

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil ditambahkan.');
    }

    public function edit(BukuKas $bukuKa)
    {
        $kategori = KategoriTransaksi::all();
        return view('pages.buku-kas.edit', compact('bukuKa', 'kategori'));
    }

    public function update(Request $request, BukuKas $bukuKa)
    {
        // --- PERBAIKAN DI SINI ---
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255', // Diubah dari 'keterangan'
            'jumlah' => 'required|numeric|min:0',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
        ]);
        
        // Menggunakan array untuk memastikan hanya field yang benar yang diupdate
        $bukuKa->update([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi, // Diubah dari 'keterangan'
            'jumlah' => $request->jumlah,
            'tipe' => $request->tipe,
            'id_kategori' => $request->id_kategori,
        ]);

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil diperbarui.');
    }

    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }

    // Fungsi export tidak perlu diubah
    public function exportExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('Y-m'));
        return Excel::download(new BukuKasExport($bulan), 'buku-kas-'.$bulan.'.xlsx');
    }

    public function exportPdf(Request $request)
    {
        $selectedMonth = $request->get('bulan', Carbon::now()->format('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $bukuKas = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
            ->orderBy('tanggal', 'asc')
            ->get();
            
        $totalPemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;

        $pdf = PDF::loadView('pages.buku-kas.buku-kas-pdf', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir'));
        return $pdf->download('buku-kas-'.$selectedMonth.'.pdf');
    }
}