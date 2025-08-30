<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
            'notifikasi'
        ));
    }
}