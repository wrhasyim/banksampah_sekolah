<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\JenisSampah;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Exports\LaporanPenjualanExport;
use App\Exports\LaporanTransaksiExport;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        // --- FILTER UTAMA ---
        $filters = $request->only(['start_date', 'end_date', 'nama_siswa', 'transaction_type', 'month', 'start_date_laba_rugi', 'end_date_laba_rugi']);
        $startDate = $request->filled('start_date') ? $request->start_date : Carbon::now()->startOfMonth()->toDateString();
        $endDate = $request->filled('end_date') ? $request->end_date : Carbon::now()->endOfMonth()->toDateString();

        // --- DATA LAPORAN TRANSAKSI ---
        $transaksi = $this->getTransaksiData($request, $startDate, $endDate);
        $transaksiPaginated = new \Illuminate\Pagination\LengthAwarePaginator(
            $transaksi->forPage($request->input('page', 1), 10),
            $transaksi->count(),
            10,
            $request->input('page', 1),
            ['path' => $request->url(), 'query' => $request->query()]
        );

        // --- DATA LAPORAN PENJUALAN ---
        $selectedMonth = $request->input('month', Carbon::now()->format('Y-m'));
        $penjualan = Penjualan::with('detailPenjualan.jenisSampah')
            ->whereYear('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->year)
            ->whereMonth('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->month)
            ->get();

        // --- DATA LAPORAN LABA RUGI ---
        $startLabaRugi = $request->input('start_date_laba_rugi', Carbon::now()->startOfMonth()->toDateString());
        $endLabaRugi = $request->input('end_date_laba_rugi', Carbon::now()->endOfMonth()->toDateString());
        $totalPenjualan = Penjualan::whereBetween('tanggal_penjualan', [$startLabaRugi, $endLabaRugi])->sum('total_harga');
        $totalInsentif = DB::table('pembayaran_insentifs')->whereBetween('tanggal_pembayaran', [$startLabaRugi, $endLabaRugi])->sum('total_dibayar');
        $pengeluaranLain = DB::table('buku_kas')->where('tipe', 'pengeluaran')->whereBetween('tanggal', [$startLabaRugi, $endLabaRugi])->sum('jumlah');
        $labaRugi = $totalPenjualan - ($totalInsentif + $pengeluaranLain);

        return view('pages.laporan.index', [
            'transaksi' => $transaksiPaginated,
            'penjualan' => $penjualan,
            'filters' => $filters,
            'selectedMonth' => $selectedMonth,
            'totalPenjualan' => $totalPenjualan,
            'totalInsentif' => $totalInsentif,
            'pengeluaranLain' => $pengeluaranLain,
            'labaRugi' => $labaRugi,
            'startLabaRugi' => $startLabaRugi,
            'endLabaRugi' => $endLabaRugi,
        ]);
    }

    // Helper function untuk mengambil data transaksi (digunakan di index dan export)
    private function getTransaksiData(Request $request, $startDate, $endDate) {
        $transaksi = collect([]);
        $transactionTypesInput = $request->input('transaction_type');
        $transactionTypes = (!empty($transactionTypesInput) && is_string($transactionTypesInput)) ? explode(',', $transactionTypesInput) : ['setoran', 'penarikan'];
        if (empty(array_filter($transactionTypes))) {
            $transactionTypes = ['setoran', 'penarikan'];
        }

        if (in_array('setoran', $transactionTypes)) {
            $setoran = Setoran::with('siswa.pengguna')
                ->whereBetween(DB::raw('DATE(created_at)'), [$startDate, $endDate])
                ->when($request->filled('nama_siswa'), function ($query) use ($request) {
                    $query->whereHas('siswa.pengguna', fn($q) => $q->where('nama_lengkap', 'like', '%' . $request->nama_siswa . '%'));
                })->get()->map(function($item) {
                    $item->jenis_transaksi = 'Setoran';
                    $item->nama = optional(optional($item->siswa)->pengguna)->nama_lengkap ?? 'Siswa Dihapus';
                    $item->debit = $item->total_harga; $item->kredit = 0; $item->tanggal = $item->created_at;
                    return $item;
                });
            $transaksi = $transaksi->concat($setoran);
        }

        if (in_array('penarikan', $transactionTypes)) {
            $penarikan = Penarikan::with('siswa.pengguna')
                ->whereBetween(DB::raw('DATE(created_at)'), [$startDate, $endDate])
                ->when($request->filled('nama_siswa'), function ($query) use ($request) {
                    $query->whereHas('siswa.pengguna', fn($q) => $q->where('nama_lengkap', 'like', '%' . $request->nama_siswa . '%'));
                })->get()->map(function($item) {
                    $item->jenis_transaksi = 'Penarikan';
                    $item->nama = optional(optional($item->siswa)->pengguna)->nama_lengkap ?? 'Siswa Dihapus';
                    $item->debit = 0; $item->kredit = $item->jumlah_penarikan; $item->tanggal = $item->created_at;
                    return $item;
                });
            $transaksi = $transaksi->concat($penarikan);
        }
        return $transaksi->sortByDesc('tanggal');
    }
    
    public function exportTransaksiExcel(Request $request) 
    {
        return Excel::download(new LaporanTransaksiExport($request->all()), 'laporan-transaksi.xlsx');
    }

    public function exportTransaksiPdf(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $kelasList = Kelas::with(['siswa.pengguna'])->orderBy('nama_kelas')->get();
        $jenisSampahList = JenisSampah::orderBy('nama_sampah')->get();
        $dataLaporan = [];
    
        foreach ($kelasList as $kelas) {
            $dataKelas = ['nama_kelas' => $kelas->nama_kelas, 'siswa' => [], 'total_per_sampah' => array_fill_keys($jenisSampahList->pluck('id')->toArray(), 0)];
            foreach ($kelas->siswa as $siswa) {
                $setoranSiswa = Setoran::where('siswa_id', $siswa->id)
                    ->whereBetween(DB::raw('DATE(created_at)'), [$startDate, $endDate])
                    ->select('jenis_sampah_id', DB::raw('SUM(jumlah) as total_jumlah'))
                    ->groupBy('jenis_sampah_id')->pluck('total_jumlah', 'jenis_sampah_id');
                if ($setoranSiswa->isNotEmpty()) {
                    $dataSiswa = ['nama_siswa' => $siswa->pengguna->nama_lengkap, 'setoran' => array_fill_keys($jenisSampahList->pluck('id')->toArray(), 0)];
                    foreach ($setoranSiswa as $jenis_sampah_id => $total_jumlah) {
                        if(isset($dataSiswa['setoran'][$jenis_sampah_id])) {
                            $dataSiswa['setoran'][$jenis_sampah_id] = $total_jumlah;
                            $dataKelas['total_per_sampah'][$jenis_sampah_id] += $total_jumlah;
                        }
                    }
                    $dataKelas['siswa'][] = $dataSiswa;
                }
            }
            if (!empty($dataKelas['siswa'])) { $dataLaporan[] = $dataKelas; }
        }
    
        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-transaksi-pdf', compact('dataLaporan', 'jenisSampahList', 'startDate', 'endDate'));
        $pdf->setPaper('a4', 'landscape');
        return $pdf->stream('laporan-transaksi-'.$startDate.'-'.$endDate.'.pdf');
    }

    public function exportPenjualanExcel(Request $request)
    {
        return Excel::download(new LaporanPenjualanExport($request->all()), 'laporan-penjualan.xlsx');
    }

    public function exportPenjualanPdf(Request $request)
    {
        $selectedMonth = $request->input('month', Carbon::now()->format('Y-m'));
        $penjualan = Penjualan::with('detailPenjualan.jenisSampah')
            ->whereYear('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->year)
            ->whereMonth('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->month)
            ->get();
        
        $totalPenjualan = $penjualan->sum('total_harga');

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualan', 'totalPenjualan', 'selectedMonth'));
        return $pdf->stream('laporan-penjualan-'.$selectedMonth.'.pdf');
    }

    public function exportLabaRugiPdf(Request $request)
    {
        $startDate = $request->input('start_date_laba_rugi', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date_laba_rugi', Carbon::now()->endOfMonth()->toDateString());

        $totalPenjualan = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->sum('total_harga');
        $totalInsentif = DB::table('pembayaran_insentifs')->whereBetween('tanggal_pembayaran', [$startDate, $endDate])->sum('total_dibayar');
        $pengeluaranLain = DB::table('buku_kas')->where('tipe', 'pengeluaran')->whereBetween('tanggal', [$startDate, $endDate])->sum('jumlah');
        $labaRugi = $totalPenjualan - ($totalInsentif + $pengeluaranLain);

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', compact('totalPenjualan', 'totalInsentif', 'pengeluaranLain', 'labaRugi', 'startDate', 'endDate'));
        return $pdf->stream('laporan-laba-rugi-'.$startDate.'-'.$endDate.'.pdf');
    }
}