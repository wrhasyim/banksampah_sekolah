<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas; // Import model BukuKas
use App\Exports\LaporanTransaksiExport;
use App\Exports\LaporanPenjualanExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        // Logika untuk filter bulan (tetap sama)
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        // Mengambil data transaksi untuk tab lain (tetap sama)
        $setorans = Setoran::with('siswa.pengguna')->whereBetween('created_at', [$startDate, $endDate])->orderBy('created_at', 'desc')->get();
        $penarikans = Penarikan::with('siswa.pengguna', 'kelas')->whereBetween('tanggal_penarikan', [$startDate, $endDate])->orderBy('tanggal_penarikan', 'desc')->get();
        $penjualans = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->orderBy('tanggal_penjualan', 'desc')->get();
        
        $totalSetoran = $setorans->sum('total_harga');
        $totalPenarikan = $penarikans->sum('jumlah_penarikan');
        $totalPenjualan = $penjualans->sum('total_harga');

        // --- PERBAIKAN LOGIKA LABA RUGI ---
        
        // 1. Pendapatan adalah semua pemasukan di Buku Kas pada periode yang dipilih
        $pendapatan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
                            ->where('tipe', 'pemasukan')
                            ->sum('jumlah');

        // 2. Beban adalah semua pengeluaran di Buku Kas pada periode yang dipilih
        $beban = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
                       ->where('tipe', 'pengeluaran')
                       ->sum('jumlah');
        
        // 3. Laba Rugi adalah selisihnya
        $labaRugi = $pendapatan - $beban;

        return view('pages.laporan.index', compact(
            'setorans', 'penarikans', 'penjualans', 'selectedMonth',
            'totalSetoran', 'totalPenarikan', 'totalPenjualan',
            'pendapatan', 'beban', 'labaRugi'
        ));
    }

    // ... (method export lainnya tetap sama) ...
    
    public function exportTransaksiExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('Y-m'));
        return Excel::download(new LaporanTransaksiExport($bulan), 'laporan-transaksi-'.$bulan.'.xlsx');
    }

    public function exportTransaksiPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();
        $setorans = Setoran::whereBetween('created_at', [$startDate, $endDate])->orderBy('created_at', 'desc')->get();
        $penarikans = Penarikan::whereBetween('tanggal_penarikan', [$startDate, $endDate])->orderBy('tanggal_penarikan', 'desc')->get();
        $totalSetoran = $setorans->sum('total_harga');
        $totalPenarikan = $penarikans->sum('jumlah_penarikan');
        $pdf = PDF::loadView('pages.laporan.pdf.laporan-transaksi-pdf', compact('setorans', 'penarikans', 'selectedMonth', 'totalSetoran', 'totalPenarikan', 'startDate', 'endDate'));
        return $pdf->download('laporan-transaksi-'.$selectedMonth.'.pdf');
    }

    public function exportPenjualanExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('Y-m'));
        return Excel::download(new LaporanPenjualanExport($bulan), 'laporan-penjualan-'.$bulan.'.xlsx');
    }

    public function exportPenjualanPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();
        $penjualans = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->orderBy('tanggal_penjualan', 'desc')->get();
        $totalPenjualan = $penjualans->sum('total_harga');
        $pdf = PDF::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualans', 'selectedMonth', 'totalPenjualan'));
        return $pdf->download('laporan-penjualan-'.$selectedMonth.'.pdf');
    }

    public function exportLabaRugiPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $pendapatan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pemasukan')->sum('jumlah');
        $beban = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pengeluaran')->sum('jumlah');
        $labaRugi = $pendapatan - $beban;

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', compact('pendapatan', 'beban', 'labaRugi', 'selectedMonth'));
        return $pdf->download('laporan-laba-rugi-'.$selectedMonth.'.pdf');
    }
}