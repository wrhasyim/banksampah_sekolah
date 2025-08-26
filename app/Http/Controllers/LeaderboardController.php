<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index()
    {
        // Peringkat Siswa Berdasarkan Total Setoran (Query Diperbaiki)
        $studentRankings = Siswa::select(
                'pengguna.nama_lengkap as nama', // Mengambil nama dari tabel pengguna
                'kelas.nama as nama_kelas', 
                DB::raw('SUM(setoran.total_harga) as total_setoran')
            )
            ->join('pengguna', 'siswa.pengguna_id', '=', 'pengguna.id') // JOIN ke tabel pengguna
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->join('kelas', 'siswa.kelas_id', '=', 'kelas.id')
            ->groupBy('siswa.id', 'pengguna.nama_lengkap', 'kelas.nama')
            ->orderByDesc('total_setoran')
            ->limit(10)
            ->get();

        // Peringkat Kelas Berdasarkan Total Setoran (Query sudah benar)
        $classRankings = Siswa::select(
                'kelas.nama as nama_kelas', 
                DB::raw('SUM(setoran.total_harga) as total_setoran')
            )
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->join('kelas', 'siswa.kelas_id', '=', 'kelas.id')
            ->groupBy('kelas.nama')
            ->orderByDesc('total_setoran')
            ->limit(5)
            ->get();

        return view('pages.leaderboard.index', compact('studentRankings', 'classRankings'));
    }
}