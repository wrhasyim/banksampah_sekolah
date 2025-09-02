<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use App\Models\Badge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->input('filter', 'minggu_ini');
        $dateRange = $this->getDateRange($filter);

        // --- REVISI PERINGKAT SISWA ---
        // 1. Memfilter pengguna dengan role 'siswa'.
        // 2. Memfilter agar siswa yang ada di kelas 'Guru' tidak ikut tampil.
        $topSiswa = Siswa::whereHas('pengguna', function ($query) {
                $query->where('role', 'siswa');
            })
            ->whereHas('kelas', function ($query) {
                $query->where('nama_kelas', '!=', 'Guru');
            })
            ->with('pengguna', 'kelas')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                $query->whereBetween('created_at', $dateRange);
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(10)
            ->get();

        // --- REVISI PERINGKAT KELAS ---
        // 1. Tidak menampilkan kelas 'Guru'.
        // 2. Memastikan total setoran kelas hanya dihitung dari setoran milik siswa.
        $topKelas = Kelas::where('nama_kelas', '!=', 'Guru')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange)
                      ->whereHas('siswa.pengguna', function($q) {
                            $q->where('role', 'siswa');
                      });
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(10)
            ->get();
            
        $badges = Badge::orderBy('min_points', 'asc')->get();

        return view('pages.leaderboard.index', [
            'topSiswa' => $topSiswa,
            'topKelas' => $topKelas,
            'filter' => $filter,
            'badges' => $badges,
        ]);
    }

    private function getDateRange($filter)
    {
        switch ($filter) {
            case 'hari_ini':
                return [now()->startOfDay(), now()->endOfDay()];
            case 'bulan_ini':
                return [now()->startOfMonth(), now()->endOfMonth()];
            case 'tahun_ini':
                return [now()->startOfYear(), now()->endOfYear()];
            case 'minggu_ini':
            default:
                return [now()->startOfWeek(), now()->endOfWeek()];
        }
    }
}