<?php

namespace App\Http\Controllers;

use App\Exports\LaporanPenjualanExport;
use App\Exports\LaporanTransaksiExport;
use App\Models\BukuKas;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\Setoran;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function exportTransaksiExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));
        return Excel::download(new LaporanTransaksiExport($bulan, $tahun), 'laporan-transaksi.xlsx');
    }

    public function exportTransaksiPdf(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        $setoran = Setoran::whereMonth('tanggal_setor', $bulan)->whereYear('tanggal_setor', $tahun)->get();
        $penarikan = Penarikan::whereMonth('tanggal_penarikan', $bulan)->whereYear('tanggal_penarikan', $tahun)->get();

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-transaksi-pdf', compact('setoran', 'penarikan', 'bulan', 'tahun'));
        return $pdf->download('laporan-transaksi.pdf');
    }

    public function exportPenjualanExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));
        return Excel::download(new LaporanPenjualanExport($bulan, $tahun), 'laporan-penjualan.xlsx');
    }

    public function exportPenjualanPdf(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        $penjualan = Penjualan::whereMonth('tanggal_penjualan', $bulan)->whereYear('tanggal_penjualan', $tahun)->get();

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualan', 'bulan', 'tahun'));
        return $pdf->download('laporan-penjualan.pdf');
    }

    public function exportLabaRugiPdf(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        $pemasukan = BukuKas::where('tipe', 'pemasukan')->whereMonth('tanggal', $bulan)->whereYear('tanggal', $tahun)->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->whereMonth('tanggal', $bulan)->whereYear('tanggal', $tahun)->sum('jumlah');

        $labaRugi = $pemasukan - $pengeluaran;

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', compact('pemasukan', 'pengeluaran', 'labaRugi', 'bulan', 'tahun'));
        return $pdf->download('laporan-laba-rugi.pdf');
    }

    /**
     * PERBAIKAN: Menambahkan perhitungan dan pengiriman variabel $totalPenjualan.
     */
    public function index(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());
    
        $setoran = Setoran::whereBetween('tanggal_setor', [$startDate, $endDate])->orderBy('tanggal_setor', 'desc')->get();
        $penarikan = Penarikan::whereBetween('tanggal_penarikan', [$startDate, $endDate])->orderBy('tanggal_penarikan', 'desc')->get();
        $penjualan = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->orderBy('tanggal_penjualan', 'desc')->get();
    
        // Menghitung total
        $totalPenjualan = $penjualan->sum('total_harga'); // <-- Tambahkan baris ini
        $pemasukan = BukuKas::where('tipe', 'pemasukan')->whereBetween('tanggal', [$startDate, $endDate])->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->whereBetween('tanggal', [$startDate, $endDate])->sum('jumlah');
        
        $bulan = Carbon::parse($startDate)->format('m');
        $tahun = Carbon::parse($startDate)->format('Y');

        return view('pages.laporan.index', compact('setoran', 'penarikan', 'penjualan', 'totalPenjualan', 'pemasukan', 'pengeluaran', 'bulan', 'tahun', 'startDate', 'endDate'));
    }

    public function export(Request $request)
    {
        // ...
    }
}