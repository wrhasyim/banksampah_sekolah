<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Exports\LaporanTransaksiExport;
use App\Exports\LaporanPenjualanExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;


class ReportController extends Controller
{
    public function index(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        // PERBAIKAN: Mengganti 'tanggal_setor' menjadi 'created_at'
        $setorans = Setoran::whereBetween('created_at', [$startDate, $endDate])
                           ->orderBy('created_at', 'desc')
                           ->get();
        
        // PERBAIKAN: Mengganti 'tanggal_penarikan' menjadi 'created_at'
        $penarikans = Penarikan::whereBetween('created_at', [$startDate, $endDate])
                               ->orderBy('created_at', 'desc')
                               ->get();

        $penjualans = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])
                               ->orderBy('tanggal_penjualan', 'desc')
                               ->get();

        $totalSetoran = $setorans->sum('total');
        $totalPenarikan = $penarikans->sum('jumlah');
        $totalPenjualan = $penjualans->sum('total_harga');

        // Laba Rugi
        $pendapatan = $totalPenjualan;
        $beban = $totalSetoran; // Asumsi beban adalah total setoran
        $labaRugi = $pendapatan - $beban;

        return view('pages.laporan.index', compact(
            'setorans', 'penarikans', 'penjualans', 'selectedMonth',
            'totalSetoran', 'totalPenarikan', 'totalPenjualan',
            'pendapatan', 'beban', 'labaRugi'
        ));
    }

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

        // PERBAIKAN: Mengganti 'tanggal_setor' menjadi 'created_at'
        $setorans = Setoran::whereBetween('created_at', [$startDate, $endDate])
                           ->orderBy('created_at', 'desc')
                           ->get();

        // PERBAIKAN: Mengganti 'tanggal_penarikan' menjadi 'created_at'
        $penarikans = Penarikan::whereBetween('created_at', [$startDate, $endDate])
                               ->orderBy('created_at', 'desc')
                               ->get();
        
        $totalSetoran = $setorans->sum('total');
        $totalPenarikan = $penarikans->sum('jumlah');

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-transaksi-pdf', compact('setorans', 'penarikans', 'selectedMonth', 'totalSetoran', 'totalPenarikan'));
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

        $penjualans = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])
                               ->orderBy('tanggal_penjualan', 'desc')
                               ->get();
        
        $totalPenjualan = $penjualans->sum('total_harga');

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualans', 'selectedMonth', 'totalPenjualan'));
        return $pdf->download('laporan-penjualan-'.$selectedMonth.'.pdf');
    }

    public function exportLabaRugiPdf(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        // PERBAIKAN: Mengganti 'tanggal_setor' menjadi 'created_at'
        $totalSetoran = Setoran::whereBetween('created_at', [$startDate, $endDate])->sum('total');
        $totalPenjualan = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->sum('total_harga');
        
        $pendapatan = $totalPenjualan;
        $beban = $totalSetoran;
        $labaRugi = $pendapatan - $beban;

        $pdf = PDF::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', compact('pendapatan', 'beban', 'labaRugi', 'selectedMonth'));
        return $pdf->download('laporan-laba-rugi-'.$selectedMonth.'.pdf');
    }
}