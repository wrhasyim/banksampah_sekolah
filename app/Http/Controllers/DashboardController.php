<?php

namespace App\Http\Controllers;

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
            // Data untuk Admin Dashboard
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            
            // Menghitung total berat sampah yang belum terjual
            // Menggunakan nama kolom 'jumlah' sesuai file migrasi database
            $totalSetoran = Setoran::sum('jumlah'); 
            $totalPenjualan = DB::table('detail_penjualan')->sum('jumlah');
            $stokSampah = $totalSetoran - $totalPenjualan;

            return view('dashboard-admin', compact('totalSiswa', 'totalSaldo', 'stokSampah'));

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