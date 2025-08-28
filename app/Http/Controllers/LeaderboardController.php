<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $filter = $request->input('filter', 'minggu_ini');
        $dateRange = $this->getDateRange($filter);

        $topSiswa = Siswa::withSum(['setoran' => function ($query) use ($dateRange) {
            $query->whereBetween('created_at', $dateRange);
        }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(10)
            ->get();


        $topKelas = Kelas::withSum(['setoran' => function ($query) use ($dateRange) {
            // FINAL FIX: Explicitly specify the table name for 'created_at'
            $query->whereBetween('setoran.created_at', $dateRange);
        }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(10)
            ->get();

        return view('pages.leaderboard.index', [
            'topSiswa' => $topSiswa,
            'topKelas' => $topKelas,
            'filter' => $filter,
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