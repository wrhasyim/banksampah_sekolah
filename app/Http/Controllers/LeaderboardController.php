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

        // --- PERBAIKAN FINAL DI SINI ---
        // 1. Menambahkan has('pengguna') untuk memfilter HANYA siswa yang masih aktif.
        // 2. Menambahkan with('pengguna', 'kelas') untuk memuat data nama dan kelas.
        $topSiswa = Siswa::has('pengguna') // <-- Filter utama
            ->with('pengguna', 'kelas')   // <-- Memuat relasi
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                $query->whereBetween('created_at', $dateRange);
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(10)
            ->get();

        $topKelas = Kelas::withSum(['setoran' => function ($query) use ($dateRange) {
            $query->whereBetween('setoran.created_at', $dateRange);
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