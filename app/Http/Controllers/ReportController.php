<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas;
use Carbon\Carbon;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Exports\LaporanTransaksiExport;
use App\Exports\LaporanPenjualanExport;

class ReportController extends Controller
{
    /**
     * Mengambil data yang difilter untuk semua laporan.
     */
    private function getFilteredData(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        // Data Laporan Transaksi (Setoran dan Penarikan)
        $setorans = Setoran::with('siswa')
            ->whereBetween('tanggal_setor', [$startDate, $endDate])
            ->latest('tanggal_setor')->get();
            
        $penarikans = Penarikan::with('siswa')
            ->whereBetween('tanggal_penarikan', [$startDate, $endDate])
            ->latest('tanggal_penarikan')->get();
            
        $totalSetoran = $setorans->sum('total_harga');
        $totalPenarikan = $penarikans->sum('jumlah_penarikan');

        // Data Laporan Penjualan
        $penjualans = Penjualan::with('details.jenisSampah')
            ->whereBetween('tanggal_penjualan', [$startDate, $endDate])
            ->latest('tanggal_penjualan')->get();
        $totalPenjualan = $penjualans->sum('total_harga');

        // Data Laporan Laba Rugi dari Buku Kas
        $pendapatan = BukuKas::where('tipe', 'pemasukan')
            ->whereBetween('tanggal', [$startDate, $endDate])
            ->sum('jumlah');
        $beban = BukuKas::where('tipe', 'pengeluaran')
            ->whereBetween('tanggal', [$startDate, $endDate])
            ->sum('jumlah');
        $labaRugi = $pendapatan - $beban;

        return compact(
            'setorans', 'penarikans', 'totalSetoran', 'totalPenarikan',
            'penjualans', 'totalPenjualan',
            'pendapatan', 'beban', 'labaRugi',
            'startDate', 'endDate'
        );
    }
    
    /**
     * Menampilkan halaman utama laporan.
     */
    public function index(Request $request)
    {
        $data = $this->getFilteredData($request);
        return view('pages.laporan.index', $data);
    }

    /**
     * Ekspor Laporan Transaksi ke Excel.
     */
    public function exportTransaksiExcel(Request $request)
    {
        $data = $this->getFilteredData($request);
        $fileName = 'laporan-transaksi-' . Carbon::now()->format('Y-m-d') . '.xlsx';
        return Excel::download(new LaporanTransaksiExport($data), $fileName);
    }

    /**
     * Ekspor Laporan Transaksi ke PDF.
     */
    public function exportTransaksiPdf(Request $request)
    {
        $data = $this->getFilteredData($request);
        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-transaksi-pdf', $data);
        $fileName = 'laporan-transaksi-' . Carbon::now()->format('Y-m-d') . '.pdf';
        return $pdf->download($fileName);
    }

    /**
     * Ekspor Laporan Penjualan ke Excel.
     */
    public function exportPenjualanExcel(Request $request)
    {
        $data = $this->getFilteredData($request);
        $fileName = 'laporan-penjualan-' . Carbon::now()->format('Y-m-d') . '.xlsx';
        return Excel::download(new LaporanPenjualanExport($data), $fileName);
    }

    /**
     * Ekspor Laporan Penjualan ke PDF.
     */
    public function exportPenjualanPdf(Request $request)
    {
        $data = $this->getFilteredData($request);
        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-penjualan-pdf', $data);
        $fileName = 'laporan-penjualan-' . Carbon::now()->format('Y-m-d') . '.pdf';
        return $pdf->download($fileName);
    }

    /**
     * Ekspor Laporan Laba Rugi ke PDF.
     */
    public function exportLabaRugiPdf(Request $request)
    {
        $data = $this->getFilteredData($request);
        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', $data);
        $fileName = 'laporan-laba-rugi-' . Carbon::now()->format('Y-m-d') . '.pdf';
        return $pdf->download($fileName);
    }
}