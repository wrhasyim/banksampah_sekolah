<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use Illuminate\Http\Request;
use App\Exports\BukuKasExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use App\Models\KategoriTransaksi;
use Illuminate\Support\Facades\DB; // <--- PERBAIKAN DI SINI

class BukuKasController extends Controller
{
    public function index(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $bukuKas = BukuKas::whereMonth('tanggal', $startDate->month)
            ->whereYear('tanggal', $startDate->year)
            ->orderBy('tanggal', 'asc')
            ->get();

        $totalPemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;
        $kategori = KategoriTransaksi::all();

        return view('pages.buku-kas.index', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'kategori'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'keterangan' => 'required',
            'jumlah' => 'required|numeric',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
        ]);

        BukuKas::create($request->all());

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil ditambahkan.');
    }

    public function edit(BukuKas $bukuKa)
    {
        $kategori = KategoriTransaksi::all();
        return view('pages.buku-kas.edit', compact('bukuKa', 'kategori'));
    }

    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'keterangan' => 'required',
            'jumlah' => 'required|numeric',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
        ]);

        $bukuKa->update($request->all());

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil diperbarui.');
    }

    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil dihapus.');
    }

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

        $bukuKas = BukuKas::whereMonth('tanggal', $startDate->month)
            ->whereYear('tanggal', $startDate->year)
            ->orderBy('tanggal', 'asc')
            ->get();
            
        $totalPemasukan = DB::table('buku_kas')->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = DB::table('buku_kas')->where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;

        $pdf = PDF::loadView('pages.buku-kas.buku-kas-pdf', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir'));
        return $pdf->download('buku-kas-'.$selectedMonth.'.pdf');
    }
}