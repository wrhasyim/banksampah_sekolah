<?php

namespace App\Http\Controllers;

use App\Models\Penjualan;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // Data untuk Kartu Statistik
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            
            // Menghitung total nilai dalam Rupiah untuk kartu statistik
            $totalSetoran = Setoran::sum('total_harga'); 
            $totalPenjualan = Penjualan::sum('total_harga');

            // Menghitung stok sampah dalam kg (total berat setor - total berat jual)
            $stokSampah = Setoran::sum('jumlah') - DB::table('detail_penjualan')->sum('jumlah');

            // Data untuk Grafik (berdasarkan nilai Rupiah)
            $setoranBulanan = Setoran::select(
                DB::raw('sum(total_harga) as total'),
                DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month")
            )
            ->groupBy('month')
            ->orderBy('month', 'asc')
            ->get();

            $penjualanBulanan = Penjualan::select(
                DB::raw('sum(total_harga) as total'),
                DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month")
            )
            ->groupBy('month')
            ->orderBy('month', 'asc')
            ->get();
            
            // Menyatukan label bulan dari kedua sumber dan memastikan data selaras
            $labels = $setoranBulanan->pluck('month')->merge($penjualanBulanan->pluck('month'))->unique()->sort()->values();
            
            $dataSetoran = [];
            $dataPenjualan = [];

            foreach ($labels as $label) {
                $setoran = $setoranBulanan->firstWhere('month', $label);
                $dataSetoran[] = $setoran ? $setoran->total : 0;

                $penjualan = $penjualanBulanan->firstWhere('month', $label);
                $dataPenjualan[] = $penjualan ? $penjualan->total : 0;
            }

            // Mengirim SEMUA variabel yang dibutuhkan ke view
            return view('dashboard-admin', compact(
                'totalSiswa',
                'totalSaldo',
                'stokSampah',
                'totalSetoran',
                'totalPenjualan',
                'labels',
                'dataSetoran',
                'dataPenjualan'
            ));

        } elseif ($user->role === 'siswa') {
            // Data untuk Siswa Dashboard
            $siswa = $user->siswa;
            $saldo = $siswa->saldo ?? 0;
            $totalSetoran = $siswa->setoran()->sum('total_harga');
            $totalPenarikan = $siswa->penarikan()->sum('jumlah_penarikan');
            $badges = $siswa->badges ?? collect();
            
            return view('dashboard-siswa', compact('saldo', 'totalSetoran', 'totalPenarikan', 'badges'));
        }

        // Fallback default
        return view('dashboard');
    }
}