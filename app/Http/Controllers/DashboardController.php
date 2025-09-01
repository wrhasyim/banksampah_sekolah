<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas; // Import model BukuKas
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        // Statistik Sampah & Siswa (Tidak berubah)
        $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();
        $stokPerJenis = $semuaJenisSampah;
        $totalStokKg = $semuaJenisSampah->where('satuan', 'kg')->sum('stok');
        $totalStokPcs = $semuaJenisSampah->where('satuan', 'pcs')->sum('stok');
        $totalSiswa = Siswa::count();
        $totalSetoran = Setoran::sum('total_harga');

        // --- PENYESUAIAN: Perhitungan Keuangan dari Buku Kas ---
        $totalPemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $kas = $totalPemasukan - $totalPengeluaran; // Ini adalah saldo kas yang sebenarnya

        // Ringkasan Keuangan Bulanan
        $bulanIni = now()->month;
        $tahunIni = now()->year;
        $pemasukanBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaranBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pengeluaran')->sum('jumlah');
        $labaBersihBulanIni = $pemasukanBulanIni - $pengeluaranBulanIni;
        
        // Aktivitas Terkini (Tidak berubah)
        $aktivitasTerakhir = [
            'setoran' => Setoran::with('siswa.pengguna')->latest()->take(3)->get(),
            'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(3)->get(),
        ];

        // Notifikasi (Tidak berubah)
        $notifikasi = [];
        $sampahHampirHabis = $semuaJenisSampah->where('stok', '<', 10);
        if ($sampahHampirHabis->isNotEmpty()) {
            $notifikasi[] = "Stok untuk beberapa jenis sampah hampir habis. Mohon segera diperiksa.";
        }
        
        return view('dashboard-admin', compact(
            'totalStokKg', 
            'totalStokPcs', 
            'totalSiswa', 
            'totalSetoran',
            'kas', // Variabel $kas yang sudah diperbaiki
            'stokPerJenis',
            'aktivitasTerakhir',
            'notifikasi',
            'pemasukanBulanIni',
            'pengeluaranBulanIni',
            'labaBersihBulanIni'
        ));
    }

    // Method getChartData() tidak perlu diubah, biarkan seperti yang sudah ada
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
                $labels[] = $date->format('d M');
                $dataSetoran[] = Setoran::whereDate('created_at', $date)->sum('total_harga');
                $dataPenjualan[] = Penjualan::whereDate('created_at', $date)->sum('total_harga');
            }
        }

        return response()->json(compact('labels', 'dataSetoran', 'dataPenjualan'));
    }
    public function getSampahChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        $query = \App\Models\Setoran::query();

        if ($period == 'monthly') {
            // Mengambil data untuk bulan saat ini
            $query->whereYear('created_at', now()->year)->whereMonth('created_at', now()->month);
        } else {
            $days = 0;
            if ($period == 'today') $days = 0;
            if ($period == '7d') $days = 6;
            if ($period == '30d') $days = 29;

            $startDate = now()->subDays($days)->startOfDay();
            $endDate = now()->endOfDay();
            $query->whereBetween('created_at', [$startDate, $endDate]);
        }

        $setorans = $query->get();

        $sampahData = [];
        // Proses data dari kolom JSON
        foreach ($setorans as $setoran) {
            $details = json_decode($setoran->detail_setoran, true);
            if (is_array($details)) {
                foreach ($details as $detail) {
                    if (isset($detail['id']) && isset($detail['jumlah']) && is_numeric($detail['jumlah'])) {
                        if (!isset($sampahData[$detail['id']])) {
                            $sampahData[$detail['id']] = 0;
                        }
                        $sampahData[$detail['id']] += $detail['jumlah'];
                    }
                }
            }
        }

        $jenisSampahIds = array_keys($sampahData);
        $jenisSampah = \App\Models\JenisSampah::whereIn('id', $jenisSampahIds)->pluck('nama_sampah', 'id');

        $labels = [];
        $data = [];
        foreach ($sampahData as $id => $jumlah) {
            if (isset($jenisSampah[$id])) {
                $labels[] = $jenisSampah[$id];
                $data[] = $jumlah;
            }
        }

        return response()->json(compact('labels', 'data'));
    }
}