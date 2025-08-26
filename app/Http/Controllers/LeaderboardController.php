<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index()
    {
        // Peringkat Siswa Berdasarkan Total Setoran
        $studentRankings = Siswa::select('siswa.nama', 'kelas.nama as nama_kelas', DB::raw('SUM(setoran.total_harga) as total_setoran'))
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->join('kelas', 'siswa.kelas_id', '=', 'kelas.id')
            ->groupBy('siswa.id', 'siswa.nama', 'kelas.nama')
            ->orderByDesc('total_setoran')
            ->limit(10) // Ambil 10 siswa teratas
            ->get();

        // Peringkat Kelas Berdasarkan Total Setoran
        $classRankings = Siswa::select('kelas.nama as nama_kelas', DB::raw('SUM(setoran.total_harga) as total_setoran'))
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->join('kelas', 'siswa.kelas_id', '=', 'kelas.id')
            ->groupBy('kelas.nama')
            ->orderByDesc('total_setoran')
            ->limit(5) // Ambil 5 kelas teratas
            ->get();

        return view('pages.leaderboard.index', compact('studentRankings', 'classRankings'));
    }
}