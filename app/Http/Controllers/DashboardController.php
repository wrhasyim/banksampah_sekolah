<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // Data Ringkasan
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            $totalSetoranHariIni = Setoran::whereDate('created_at', today())->sum('total_harga');

            // --- TAMBAHKAN LOGIKA PERINGKAT DI SINI ---
            $peringkatSiswa = Siswa::select('id_pengguna', DB::raw('SUM(setoran.jumlah_satuan) as total_satuan'))
                ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->with('pengguna')
                ->groupBy('id_pengguna')
                ->orderByDesc('total_satuan')
                ->limit(5)
                ->get();
            
            $peringkatKelas = Kelas::select('nama_kelas', DB::raw('SUM(setoran.jumlah_satuan) as total_satuan'))
                ->join('siswa', 'kelas.id', '=', 'siswa.id_kelas')
                ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->groupBy('nama_kelas')
                ->orderByDesc('total_satuan')
                ->limit(5)
                ->get();
            
            return view('dashboard-admin', compact('totalSiswa', 'totalSaldo', 'totalSetoranHariIni', 'peringkatSiswa', 'peringkatKelas'));

        } elseif ($user->role === 'siswa') {
            $siswa = $user->siswa;
            if (!$siswa) {
                Auth::logout();
                return redirect('/login')->with('error', 'Data siswa tidak ditemukan. Silakan hubungi admin.');
            }
            $setoran = Setoran::where('id_siswa', $siswa->id)->with('jenisSampah')->latest()->take(5)->get();
            return view('dashboard-siswa', compact('siswa', 'setoran'));
        }
        return view('dashboard');
    }
}