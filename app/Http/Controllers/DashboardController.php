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

class DashboardController extends Controller
{
    public function index()
    {
        $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();
        $totalSiswa = Siswa::count();
        $nilaiStokJual = JenisSampah::sum(DB::raw('stok * harga_jual'));
        $modalStokBeli = JenisSampah::sum(DB::raw('stok * harga_per_satuan'));
        $kas = BukuKas::where('tipe', 'pemasukan')->sum('jumlah') - BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $totalInsentifBelumDibayar = Insentif::where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif');
        $stokPerJenis = $semuaJenisSampah;
        
        $bulanIni = now()->month;
        $tahunIni = now()->year;
        $pemasukanBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaranBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pengeluaran')->sum('jumlah');
        $labaBersihBulanIni = $pemasukanBulanIni - $pengeluaranBulanIni;

        $aktivitasTerakhir = [
            'setoran' => Setoran::with('siswa.pengguna')->latest()->take(5)->get(),
            'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(5)->get(),
        ];
        
        return view('dashboard-admin', compact(
            'totalSiswa', 
            'kas',
            'nilaiStokJual',
            'modalStokBeli',
            'totalInsentifBelumDibayar',
            'stokPerJenis',
            'aktivitasTerakhir',
            'labaBersihBulanIni'
        ));
    }

    public function getChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
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

        return response()->json(compact('labels', 'dataSetoran', 'dataPenjualan'));
    }

    /**
     * Menyediakan data untuk Bubble Chart Profitabilitas Stok.
     */
    public function getBubbleChartData()
    {
        $data = JenisSampah::where('stok', '>', 0)
            ->get()
            ->map(function ($sampah) {
                // MODIFIKASI KUNCI: Formula penskalaan radius yang baru dan lebih aman
                $radius = (sqrt($sampah->stok) * 1.5) + 5;
                $maxRadius = 75; // Batas maksimal ukuran gelembung

                return [
                    'x'      => (float) $sampah->harga_per_satuan,
                    'y'      => (float) $sampah->harga_jual,
                    'r'      => min($radius, $maxRadius), // Mencegah gelembung terlalu besar
                    'label'  => $sampah->nama_sampah,
                    'stok'   => (float) $sampah->stok,
                    'satuan' => $sampah->satuan
                ];
            });

        return response()->json($data);
    }
}