<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon; // Pastikan Carbon diimpor

class DashboardController extends Controller
{
    public function index()
    {
        // 1. Ambil semua data jenis sampah yang aktif. Ini akan menjadi sumber data utama kita.
        $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();

        // 2. Kirim koleksi ini langsung ke view untuk ditampilkan di daftar "Stok Sampah per Jenis".
        // Variabelnya kita samakan dengan yang ada di view, yaitu 'stokPerJenis'.
        $stokPerJenis = $semuaJenisSampah;

        // 3. Hitung total stok terpisah (kg dan pcs) dari koleksi yang sudah kita ambil.
        $totalStokKg = $semuaJenisSampah->where('satuan', 'kg')->sum('stok');
        $totalStokPcs = $semuaJenisSampah->where('satuan', 'pcs')->sum('stok');
        
        // 4. Hitung statistik lainnya (tidak perlu diubah)
        $totalSiswa = Siswa::count();
        $totalSetoran = Setoran::sum('total_harga');
        $kas = Penjualan::sum('total_harga');

        // --- PENAMBAHAN: Ringkasan Keuangan Bulanan ---
        $bulanIni = now()->month;
        $tahunIni = now()->year;

        // Pemasukan = total penjualan bulan ini
        $pemasukanBulanIni = Penjualan::whereYear('created_at', $tahunIni)->whereMonth('created_at', $bulanIni)->sum('total_harga');
        
        // Pengeluaran = total penarikan saldo oleh siswa bulan ini
        $pengeluaranBulanIni = Penarikan::whereYear('created_at', $tahunIni)->whereMonth('created_at', $bulanIni)->sum('jumlah_penarikan');

        // Laba Bersih = Pemasukan - Pengeluaran
        $labaBersihBulanIni = $pemasukanBulanIni - $pengeluaranBulanIni;
        
        // Data untuk chart (tidak perlu diubah)
        $labels = [];
        $dataSetoran = [];
        $dataPenjualan = [];
        for ($i = 6; $i >= 0; $i--) {
            $date = now()->subMonths($i);
            $month = $date->format('M');
            $year = $date->format('Y');
            $labels[] = "$month $year";
            $dataSetoran[] = Setoran::whereYear('created_at', $year)->whereMonth('created_at', $date->month)->sum('total_harga');
            $dataPenjualan[] = Penjualan::whereYear('created_at', $year)->whereMonth('created_at', $date->month)->sum('total_harga');
        }

        // Data untuk aktivitas terkini (tidak perlu diubah)
        $aktivitasTerakhir = [
            'setoran' => Setoran::with('siswa.pengguna')->latest()->take(3)->get(),
            'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(3)->get(),
        ];

        // Variabel notifikasi (tidak perlu diubah)
        $notifikasi = [];
        $sampahHampirHabis = $semuaJenisSampah->where('stok', '<', 10);
        if ($sampahHampirHabis->isNotEmpty()) {
            $notifikasi[] = "Stok untuk beberapa jenis sampah hampir habis. Mohon segera diperiksa.";
        }
        
        // 5. Kirim semua data yang sudah benar ke view
        return view('dashboard-admin', compact(
            'totalStokKg', 
            'totalStokPcs', 
            'totalSiswa', 
            'totalSetoran',
            'kas',
            'stokPerJenis',
            'labels',
            'dataSetoran',
            'dataPenjualan',
            'aktivitasTerakhir',
            'notifikasi',
            'pemasukanBulanIni',      // Variabel baru
            'pengeluaranBulanIni',   // Variabel baru
            'labaBersihBulanIni'     // Variabel baru
        ));
    }
     // --- METHOD BARU UNTUK DATA CHART ---
    public function getChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        $labels = [];
        $dataSetoran = [];
        $dataPenjualan = [];

        if ($period == 'monthly') {
            for ($i = 6; $i >= 0; $i--) {
                $date = now()->subMonths($i);
                $labels[] = $date->format('M Y');
                $dataSetoran[] = Setoran::whereYear('created_at', $date->year)->whereMonth('created_at', $date->month)->sum('total_harga');
                $dataPenjualan[] = Penjualan::whereYear('created_at', $date->year)->whereMonth('created_at', $date->month)->sum('total_harga');
            }
        } else {
            $days = 0;
            if ($period == 'today') $days = 0;
            if ($period == '7d') $days = 6;
            if ($period == '30d') $days = 29;

            for ($i = $days; $i >= 0; $i--) {
                $date = now()->subDays($i);
                $labels[] = $date->format('d M'); // Format: 25 Aug
                $dataSetoran[] = Setoran::whereDate('created_at', $date)->sum('total_harga');
                $dataPenjualan[] = Penjualan::whereDate('created_at', $date)->sum('total_harga');
            }
        }

        return response()->json(compact('labels', 'dataSetoran', 'dataPenjualan'));
    }
}