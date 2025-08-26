<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index()
    {
        // Peringkat Siswa Berdasarkan Total Setoran (Query Final & Benar)
        $studentRankings = Siswa::select(
                'pengguna.nama_lengkap as nama',
                'kelas.nama_kelas as nama_kelas',
                DB::raw('SUM(setoran.total_harga) as total_setoran')
            )
            ->join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
            ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
            ->join('kelas', 'siswa.id_kelas', '=', 'kelas.id') // DIUBAH DISINI
            ->groupBy('siswa.id', 'pengguna.nama_lengkap', 'kelas.nama_kelas')
            ->orderByDesc('total_setoran')
            ->limit(10)
            ->get();

        // Peringkat Kelas Berdasarkan Total Setoran (Query Final & Benar)
        $classRankings = Siswa::select(
                'kelas.nama_kelas as nama_kelas',
                DB::raw('SUM(setoran.total_harga) as total_setoran')
            )
            ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
            ->join('kelas', 'siswa.id_kelas', '=', 'kelas.id') // DIUBAH DISINI
            ->groupBy('kelas.nama_kelas')
            ->orderByDesc('total_setoran')
            ->limit(5)
            ->get();

        return view('pages.leaderboard.index', compact('studentRankings', 'classRankings'));
    }
}