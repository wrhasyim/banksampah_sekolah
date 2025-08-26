<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    /**
     * Menampilkan halaman leaderboard dengan 10 siswa teratas
     * berdasarkan total setoran.
     */
    public function index()
    {
        $leaderboard = Siswa::join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id') // DIPERBAIKI
            ->join('kelas', 'siswa.id_kelas', '=', 'kelas.id')
            ->select(
                'pengguna.nama_lengkap as nama',
                'kelas.nama_kelas as nama_kelas',
                DB::raw('SUM(setoran.total_harga) as total_setoran')
            )
            ->groupBy('siswa.id', 'pengguna.nama_lengkap', 'kelas.nama_kelas')
            ->orderByDesc('total_setoran')
            ->limit(10)
            ->get();

        return view('pages.leaderboard.index', compact('leaderboard'));
    }
}