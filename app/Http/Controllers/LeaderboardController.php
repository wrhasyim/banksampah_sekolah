<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use App\Models\Badge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Cache;

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->input('filter', 'semua_waktu');
        $rankingBy = $request->input('ranking_by', 'nominal');
        
        // Buat kunci cache yang unik berdasarkan filter yang aktif
        $cacheKey = 'leaderboard:' . $filter . ':' . $rankingBy;

        // Ambil data dari cache. Jika tidak ada, jalankan query lalu simpan di cache selama 10 menit
        $data = Cache::remember($cacheKey, now()->addMinutes(10), function () use ($filter, $rankingBy) {
            
            $dateRange = $this->getDateRange($filter);
            $sumColumn = ($rankingBy === 'jumlah') ? 'jumlah' : 'total_harga';
            $orderByColumn = 'setoran_sum_' . $sumColumn;

            // --- Peringkat Siswa ---
            $topSiswaQuery = Siswa::query()
                ->whereHas('pengguna', fn($q) => $q->where('role', 'siswa'))
                ->whereHas('kelas', fn($q) => $q->where('nama_kelas', '!=', 'Guru'))
                ->with(['pengguna', 'kelas', 'sampahDetails'])
                ->withSum(['setoran' => function ($query) use ($dateRange) {
                    if ($dateRange) {
                        $query->whereBetween('created_at', $dateRange);
                    }
                    $query->where('status', '!=', 'terlambat');
                }], $sumColumn)
                ->orderByDesc($orderByColumn)
                ->take(5);

            if ($dateRange) {
                $topSiswaQuery->with(['sampahDetails' => fn($q) => $q->whereBetween('setoran.created_at', $dateRange)]);
            }
            $topSiswa = $topSiswaQuery->get();

            // --- Peringkat Kelas ---
            $topKelasQuery = Kelas::query()
                ->where('nama_kelas', '!=', 'Guru')
                ->with(['waliKelas', 'sampahDetails'])
                ->withSum(['setoran' => function ($query) use ($dateRange) {
                    if ($dateRange) {
                        $query->whereBetween('setoran.created_at', $dateRange);
                    }
                    $query->where('status', '!=', 'terlambat')->whereHas('siswa.pengguna', fn($q) => $q->where('role', 'siswa'));
                }], $sumColumn)
                ->orderByDesc($orderByColumn)
                ->take(5);

            if ($dateRange) {
                $topKelasQuery->with(['sampahDetails' => fn($q) => $q->whereBetween('setoran.created_at', $dateRange)]);
            }
            $topKelas = $topKelasQuery->get();

            $badges = Badge::orderBy('min_points', 'asc')->get();

            // Kembalikan semua data yang dibutuhkan oleh view
            return [
                'topSiswa' => $topSiswa,
                'topKelas' => $topKelas,
                'badges' => $badges,
            ];
        });

        // Gabungkan data dari cache dengan data filter untuk dikirim ke view
        return view('pages.leaderboard.index', array_merge($data, [
            'filter' => $filter,
            'rankingBy' => $rankingBy,
        ]));
    }

    private function getDateRange($filter)
    {
        switch ($filter) {
            case 'hari_ini':
                return [Carbon::now()->startOfDay(), Carbon::now()->endOfDay()];
            case 'minggu_ini':
                return [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()];
            case 'bulan_ini':
                return [Carbon::now()->startOfMonth(), Carbon::now()->endOfMonth()];
            case 'bulan_lalu':
                return [Carbon::now()->subMonth()->startOfMonth(), Carbon::now()->subMonth()->endOfMonth()];
            case 'semua_waktu':
                return null;
            default:
                return null;
        }
    }
}