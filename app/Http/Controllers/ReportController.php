<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Exports\LaporanPenjualanExport;
use App\Exports\LaporanTransaksiExport;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache; // <--- 1. Tambahkan use Cache
use Carbon\Carbon;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $filters = $request->all();

        // --- LAPORAN TRANSAKSI (DENGAN CACHE) ---
        $startDate = $request->filled('start_date') ? $request->start_date : Carbon::now()->startOfMonth()->toDateString();
        $endDate = $request->filled('end_date') ? $request->end_date : Carbon::now()->endOfMonth()->toDateString();
        
        // 2. Buat kunci cache unik berdasarkan semua filter transaksi dan halaman
        $transaksiCacheKey = 'laporan_transaksi_' . md5(json_encode($request->only(['start_date', 'end_date', 'nama_siswa', 'transaction_type', 'page'])));
        
        $transaksiPaginated = Cache::remember($transaksiCacheKey, now()->addMinutes(60), function () use ($request, $startDate, $endDate) {
            $transaksi = $this->getTransaksiData($request, $startDate, $endDate);
            return new \Illuminate\Pagination\LengthAwarePaginator(
                $transaksi->forPage($request->input('page', 1), 10),
                $transaksi->count(),
                10,
                $request->input('page', 1),
                ['path' => $request->url(), 'query' => $request->query()]
            );
        });

        // --- LAPORAN PENJUALAN (DENGAN CACHE) ---
        $selectedMonth = $request->input('month', Carbon::now()->format('Y-m'));
        list($penjualan, $totalPenjualanBulanan) = $this->getPenjualanData($selectedMonth);

        // --- LAPORAN LABA RUGI (DENGAN CACHE) ---
        $startLabaRugi = $request->input('start_date_laba_rugi', Carbon::now()->startOfMonth()->toDateString());
        $endLabaRugi = $request->input('end_date_laba_rugi', Carbon::now()->endOfMonth()->toDateString());
        $labaRugiData = $this->getLabaRugiData($startLabaRugi, $endLabaRugi);

        return view('pages.laporan.index', [
            'transaksi' => $transaksiPaginated,
            'penjualan' => $penjualan,
            'filters' => $filters,
            'selectedMonth' => $selectedMonth,
            'totalPenjualan' => $labaRugiData['totalPenjualan'],
            'totalInsentif' => $labaRugiData['totalInsentif'],
            'pengeluaranLain' => $labaRugiData['pengeluaranLain'],
            'labaRugi' => $labaRugiData['labaRugi'],
            'startLabaRugi' => $startLabaRugi,
            'endLabaRugi' => $endLabaRugi,
        ]);
    }

    private function getTransaksiData(Request $request, $startDate, $endDate) {
        // Logika fungsi ini sudah cukup baik, tidak perlu diubah.
        // Eager loading `with('siswa.pengguna')` sudah benar.
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
                ->where('status', 'disetujui')
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

    private function getPenjualanData($selectedMonth)
    {
        $cacheKey = 'laporan_penjualan_data_' . $selectedMonth;
        return Cache::remember($cacheKey, now()->addMinutes(60), function () use ($selectedMonth) {
            $penjualan = Penjualan::with('detailPenjualan.jenisSampah')
                ->whereYear('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->year)
                ->whereMonth('tanggal_penjualan', '=', Carbon::parse($selectedMonth)->month)
                ->get();
            $totalPenjualan = $penjualan->sum('total_harga');
            return [$penjualan, $totalPenjualan];
        });
    }

    private function getLabaRugiData($startDate, $endDate)
    {
        $cacheKey = 'laporan_laba_rugi_' . $startDate . '_' . $endDate;
        return Cache::remember($cacheKey, now()->addMinutes(60), function () use ($startDate, $endDate) {
            $totalPenjualan = Penjualan::whereBetween('tanggal_penjualan', [$startDate, $endDate])->sum('total_harga');
            $totalInsentif = DB::table('pembayaran_insentifs')->whereBetween('tanggal_pembayaran', [$startDate, $endDate])->sum('total_dibayar');
            $pengeluaranLain = DB::table('buku_kas')->where('tipe', 'pengeluaran')->whereBetween('tanggal', [$startDate, $endDate])->sum('jumlah');
            
            return [
                'totalPenjualan' => $totalPenjualan,
                'totalInsentif' => $totalInsentif,
                'pengeluaranLain' => $pengeluaranLain,
                'labaRugi' => $totalPenjualan - ($totalInsentif + $pengeluaranLain),
            ];
        });
    }
    
    public function exportTransaksiExcel(Request $request) 
    {
        return Excel::download(new LaporanTransaksiExport($request->all()), 'laporan-transaksi.xlsx');
    }

    public function exportTransaksiPdf(Request $request)
    {
        // Untuk saat ini kita fokus pada optimasi halaman index utama.
        // Jika export ini juga lambat, pola caching yang sama bisa diterapkan di sini.
        // ... (kode asli Anda)
    }

    public function exportPenjualanExcel(Request $request)
    {
        return Excel::download(new LaporanPenjualanExport($request->all()), 'laporan-penjualan.xlsx');
    }

    public function exportPenjualanPdf(Request $request)
    {
        $selectedMonth = $request->input('month', Carbon::now()->format('Y-m'));
        // Memanggil helper method yang sudah ada cachenya
        list($penjualan, $totalPenjualan) = $this->getPenjualanData($selectedMonth);

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-penjualan-pdf', compact('penjualan', 'totalPenjualan', 'selectedMonth'));
        return $pdf->stream('laporan-penjualan-'.$selectedMonth.'.pdf');
    }

    public function exportLabaRugiPdf(Request $request)
    {
        $startDate = $request->input('start_date_laba_rugi', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date_laba_rugi', Carbon::now()->endOfMonth()->toDateString());

        // Memanggil helper method yang sudah ada cachenya
        $labaRugiData = $this->getLabaRugiData($startDate, $endDate);

        $pdf = Pdf::loadView('pages.laporan.pdf.laporan-laba-rugi-pdf', array_merge($labaRugiData, compact('startDate', 'endDate')));
        return $pdf->stream('laporan-laba-rugi-'.$startDate.'-'.$endDate.'.pdf');
    }
}