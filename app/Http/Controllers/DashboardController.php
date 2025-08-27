<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Penjualan;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        if (auth()->user()->role == 'admin') {
            $totalSiswa = Siswa::count();
            $totalSampah = JenisSampah::count();
            // Kolom di tabel 'setoran' adalah 'total_harga'
            $totalSetoran = Setoran::sum('total_harga'); 
            
            // PERBAIKAN FINAL: Kolom yang benar untuk tabel 'penjualan' adalah 'total_harga'
            $totalPenjualan = Penjualan::sum('total_harga');

            // --- Data untuk Chart ---
            $setoranPerBulan = Setoran::select(
                DB::raw('MONTH(created_at) as bulan'),
                DB::raw('SUM(total_harga) as total_setoran') 
            )
            ->groupBy('bulan')
            ->orderBy('bulan')
            ->pluck('total_setoran', 'bulan')->all();

            // PERBAIKAN FINAL: Menggunakan 'total_harga' di dalam SUM dari tabel 'penjualan'
            $penjualanPerBulan = Penjualan::select(
                DB::raw('MONTH(created_at) as bulan'),
                DB::raw('SUM(total_harga) as total_penjualan')
            )
            ->groupBy('bulan')
            ->orderBy('bulan')
            ->pluck('total_penjualan', 'bulan')->all();

            $labels = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
            $dataSetoran = [];
            $dataPenjualan = [];

            for ($i=1; $i <= 12; $i++) {
                $dataSetoran[] = $setoranPerBulan[$i] ?? 0;
                $dataPenjualan[] = $penjualanPerBulan[$i] ?? 0;
            }

            return view('dashboard-admin', compact('totalSiswa', 'totalSampah', 'totalSetoran', 'totalPenjualan', 'labels', 'dataSetoran', 'dataPenjualan'));
        }

        if (auth()->user()->role == 'siswa') {
            $siswa = Siswa::where('pengguna_id', auth()->id())->first();
            return view('dashboard-siswa', [
                'siswa' => $siswa,
                'totalSetoran' => $siswa->setoran->sum('total_harga'),
                'totalPenarikan' => $siswa->penarikan->sum('jumlah'),
                'totalPoint' => $siswa->points,
                'badges' => $siswa->badges,
            ]);
        }
    }
}