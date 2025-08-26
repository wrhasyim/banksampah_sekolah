<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penjualan;
use App\Models\BukuKas;
use App\Models\Pengguna;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            return $this->adminDashboard();
        } elseif ($user->role === 'siswa') {
            return $this->siswaDashboard($user);
        }

        return redirect('/');
    }

    private function adminDashboard()
    {
        // Card metrics
        $jumlahSiswa = Siswa::count();
        $totalSaldo = Siswa::sum('saldo');
        $setoranHariIni = Setoran::whereDate('created_at', today())->sum('total_harga');
        $totalPenjualan = Penjualan::sum('total_harga');
        
        // Saldo Kas
        $pemasukanKas = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaranKas = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoKas = $pemasukanKas - $pengeluaranKas;

        // Recent transactions
        $recentTransactions = BukuKas::latest('tanggal')->limit(5)->get();

        // Recent sales
        $recentSales = Penjualan::withSum('detailPenjualans', 'jumlah')->latest()->limit(5)->get();
        
        // Chart data
        $setoranChart = Setoran::select(
            DB::raw('DATE(created_at) as tanggal'),
            DB::raw('SUM(total_harga) as total')
        )
        ->where('created_at', '>=', now()->subDays(7))
        ->groupBy('tanggal')
        ->orderBy('tanggal', 'asc')
        ->get();
        
        // Top 5 Siswa
        $topSiswaData = Siswa::join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
            ->select('pengguna.nama_lengkap', DB::raw('SUM(setoran.total_harga) as total_setoran')) // DIPERBAIKI
            ->groupBy('pengguna.nama_lengkap') // DIPERBAIKI
            ->orderByDesc('total_setoran')
            ->limit(5)
            ->get();
            
        $topSiswa = [
            'labels' => $topSiswaData->pluck('nama_lengkap'), // DIPERBAIKI
            'data' => $topSiswaData->pluck('total_setoran'),
        ];
        
        return view('dashboard-admin', compact(
            'jumlahSiswa',
            'totalSaldo',
            'setoranHariIni',
            'totalPenjualan',
            'saldoKas',
            'recentTransactions',
            'recentSales',
            'setoranChart',
            'topSiswa'
        ));
    }

    private function siswaDashboard($user)
    {
        $siswa = $user->siswa;
        $saldo = $siswa->saldo;
        $totalSetoran = $siswa->setorans()->sum('total_harga');
        $totalPenarikan = $siswa->penarikans()->sum('jumlah_penarikan');
        
        $recentSetoran = $siswa->setorans()->latest('tanggal_setor')->limit(5)->get();
        
        return view('dashboard-siswa', compact(
            'siswa',
            'saldo',
            'totalSetoran',
            'totalPenarikan',
            'recentSetoran'
        ));
    }
}