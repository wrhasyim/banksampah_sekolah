<?php

namespace App\Http\Controllers;

use App\Models\Pengguna;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // Data untuk Dashboard Admin
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            $totalSetoranHariIni = Setoran::whereDate('created_at', today())->sum('total_harga');
            
            return view('dashboard-admin', compact('totalSiswa', 'totalSaldo', 'totalSetoranHariIni'));

        } elseif ($user->role === 'siswa') {
            // Data untuk Dashboard Siswa
            $siswa = $user->siswa; // Ambil data siswa yang berelasi dengan pengguna
            $setoran = Setoran::where('id_siswa', $siswa->id)->with('jenisSampah')->latest()->take(5)->get();
            
            return view('dashboard-siswa', compact('siswa', 'setoran'));
        }

        // Fallback jika ada peran lain
        return view('dashboard');
    }
}