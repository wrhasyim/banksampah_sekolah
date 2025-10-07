<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas;
use App\Models\Insentif;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache; // <-- Tambahkan ini

class DashboardController extends Controller
{
    public function index()
    {
        // Semua data dashboard akan diambil dari cache.
        // Jika cache kosong atau sudah kedaluwarsa (setelah 10 menit),
        // maka query di dalam function ini akan dijalankan dan hasilnya disimpan ke cache.
        $dashboardData = Cache::remember('admin_dashboard_data', now()->addMinutes(10), function () {
            
            $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();
            $totalSiswa = Siswa::count();
            $nilaiStokJual = JenisSampah::sum(DB::raw('stok * harga_jual'));
            $modalStokBeli = JenisSampah::sum(DB::raw('stok * harga_per_satuan'));
            $kas = BukuKas::where('tipe', 'pemasukan')->sum('jumlah') - BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
            $totalInsentifBelumDibayar = Insentif::where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif');
            
            $bulanIni = now()->month;
            $tahunIni = now()->year;
            $pemasukanBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pemasukan')->sum('jumlah');
            $pengeluaranBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pengeluaran')->sum('jumlah');
            $labaBersihBulanIni = $pemasukanBulanIni - $pengeluaranBulanIni;

            $aktivitasTerakhir = [
                'setoran' => Setoran::with('siswa.pengguna')->latest()->take(5)->get(),
                'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(5)->get(),
            ];
            
            // Kembalikan semua data dalam bentuk array untuk disimpan di cache
            return [
                'totalSiswa' => $totalSiswa, 
                'kas' => $kas,
                'nilaiStokJual' => $nilaiStokJual,
                'modalStokBeli' => $modalStokBeli,
                'totalInsentifBelumDibayar' => $totalInsentifBelumDibayar,
                'stokPerJenis' => $semuaJenisSampah,
                'aktivitasTerakhir' => $aktivitasTerakhir,
                'labaBersihBulanIni' => $labaBersihBulanIni
            ];
        });

        // Kirim data yang sudah diambil (dari cache atau dari query baru) ke view
        return view('dashboard-admin', $dashboardData);
    }

    public function getChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        
        // Buat kunci cache yang unik berdasarkan periode (bulanan/harian)
        $cacheKey = 'dashboard_chart_data:' . $period;

        $chartData = Cache::remember($cacheKey, now()->addMinutes(10), function () use ($period) {
            $labels = [];
            $dataSetoran = [];
            $dataPenjualan = [];

            if ($period == 'monthly') {
                for ($i = 5; $i >= 0; $i--) {
                    $date = now()->subMonths($i);
                    $labels[] = $date->format('M Y');
                    $dataSetoran[] = Setoran::whereYear('created_at', $date->year)->whereMonth('created_at', $date->month)->sum('total_harga');
                    $dataPenjualan[] = Penjualan::whereYear('created_at', $date->year)->whereMonth('created_at', $date->month)->sum('total_harga');
                }
            } else {
                 $days = 6;
                 for ($i = $days; $i >= 0; $i--) {
                     $date = now()->subDays($i);
                     $labels[] = $date->format('d M');
                     $dataSetoran[] = Setoran::whereDate('created_at', $date)->sum('total_harga');
                     $dataPenjualan[] = Penjualan::whereDate('created_at', $date)->sum('total_harga');
                 }
            }
            return compact('labels', 'dataSetoran', 'dataPenjualan');
        });

        return response()->json($chartData);
    }

    public function getBubbleChartData()
    {
        $bubbleData = Cache::remember('dashboard_bubble_chart_data', now()->addMinutes(10), function () {
            return JenisSampah::where('stok', '>', 0)
                ->get()
                ->map(function ($sampah) {
                    $radius = (sqrt($sampah->stok) * 1.5) + 5;
                    $maxRadius = 75;

                    return [
                        'x'      => (float) $sampah->harga_per_satuan,
                        'y'      => (float) $sampah->harga_jual,
                        'r'      => min($radius, $maxRadius),
                        'label'  => $sampah->nama_sampah,
                        'stok'   => (float) $sampah->stok,
                        'satuan' => $sampah->satuan
                    ];
                });
        });

        return response()->json($bubbleData);
    }
}