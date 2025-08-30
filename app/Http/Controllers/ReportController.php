<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas;
use App\Exports\LaporanTransaksiExport;
use App\Exports\LaporanPenjualanExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $setorans = Setoran::with('siswa.pengguna')->whereBetween('created_at', [$startDate, $endDate])->orderBy('created_at', 'desc')->get();
        $penarikans = Penarikan::with('siswa.pengguna', 'kelas')->whereBetween('tanggal_penarikan', [$startDate, $endDate])->orderBy('tanggal_penarikan', 'desc')->get();
        
        // Eager load relasi detail penjualan di sini juga
        $penjualans = Penjualan::with('detailPenjualan.jenisSampah')->whereBetween('tanggal_penjualan', [$startDate, $endDate])->orderBy('tanggal_penjualan', 'desc')->get();
        
        $totalSetoran = $setorans->sum('total_harga');
        $totalPenarikan = $penarikans->sum('jumlah_penarikan');
        $totalPenjualan = $penjualans->sum('total_harga');

        $pendapatan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
                            ->where('tipe', 'pemasukan')
                            ->sum('jumlah');

        $beban = BukuKas::whereBetween('tanggal', [$startDate, $endDate])
                       ->where('tipe', 'pengeluaran')
                       ->sum('jumlah');
        
        $labaRugi = $pendapatan - $beban;

        return view('pages.laporan.index', compact(
            'setorans', 'penarikans', 'penjualans', 'selectedMonth',
            'totalSetoran', 'totalPenarikan', 'totalPenjualan',
            'pendapatan', 'beban', 'labaRugi'
        ));
    }

    public function exportPenjualanPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        // --- PERBAIKAN DI SINI: Eager load relasi ---
        $penjualans = Penjualan::with('detailPenjualan.jenisSampah')
                                ->whereBetween('tanggal_penjualan', [$startDate, $endDate])
                                ->orderBy('tanggal_penjualan', 'desc')
                                ->get();
        
        $totalPenjualan = $penjualans->sum('total_harga');

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualans', 'selectedMonth', 'totalPenjualan', 'startDate', 'endDate'));
        return $pdf->download('laporan-penjualan-'.$selectedMonth.'.pdf');
    }

    // ... (method lainnya tetap sama) ...
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

    public function exportLabaRugiPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $pendapatan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pemasukan')->sum('jumlah');
        $beban = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pengeluaran')->sum('jumlah');
        $labaRugi = $pendapatan - $beban;

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', compact('pendapatan', 'beban', 'labaRugi', 'selectedMonth', 'startDate', 'endDate'));
        return $pdf->download('laporan-laba-rugi-'.$selectedMonth.'.pdf');
    }
}