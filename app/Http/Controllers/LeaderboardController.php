<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use App\Models\Badge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->input('filter', 'semua_waktu');
        $rankingBy = $request->input('ranking_by', 'nominal');
        $dateRange = $this->getDateRange($filter);

        $sumColumn = ($rankingBy === 'jumlah') ? 'jumlah' : 'total_harga';
        $orderByColumn = 'setoran_sum_' . $sumColumn;

        $topSiswa = Siswa::whereHas('pengguna', fn($q) => $q->where('role', 'siswa'))
            ->whereHas('kelas', fn($q) => $q->where('nama_kelas', '!=', 'Guru'))
            ->with('pengguna', 'kelas')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('created_at', $dateRange);
                }
                $query->where('status', '!=', 'terlambat');
            }], $sumColumn)
            ->orderByDesc($orderByColumn)
            ->take(5)
            ->get();

        $topSiswa->each(function ($siswa) use ($dateRange) {
            $query = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->where('setoran.siswa_id', $siswa->id)
                ->where('setoran.status', '!=', 'terlambat')
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah');
            
            if ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange);
            }
            
            $siswa->sampah_details = $query->get();
        });

        $topKelas = Kelas::where('nama_kelas', '!=', 'Guru')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('setoran.created_at', $dateRange);
                }
                $query->where('status', '!=', 'terlambat')
                      ->whereHas('siswa.pengguna', fn($q) => $q->where('role', 'siswa'));
            }], $sumColumn)
            ->orderByDesc($orderByColumn)
            ->take(5)
            ->get();
            
        $topKelas->each(function ($kelas) use ($dateRange) {
            $query = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                ->where('siswa.id_kelas', $kelas->id)
                ->where('setoran.status', '!=', 'terlambat')
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah');

            if ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange);
            }

            $kelas->sampah_details = $query->get();
        });

        $badges = Badge::orderBy('min_points', 'asc')->get();

        return view('pages.leaderboard.index', [
            'topSiswa' => $topSiswa,
            'topKelas' => $topKelas,
            'filter' => $filter,
            'rankingBy' => $rankingBy,
            'badges' => $badges,
        ]);
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