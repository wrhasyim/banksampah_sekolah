<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use App\Models\Setoran;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->input('filter', 'semua_waktu');
        $rankingBy = $request->input('ranking_by', 'jumlah');
        
        $cacheKey = 'leaderboard_hybrid:' . $filter . ':' . $rankingBy;

        $data = Cache::remember($cacheKey, now()->addMinutes(15), function () use ($filter, $rankingBy) {
            
            $dateRange = $this->getDateRange($filter);
            $sumColumn = ($rankingBy === 'jumlah') ? 'jumlah' : 'total_harga';

            // --- Peringkat Siswa ---
            $topSiswa = $this->getTopSiswa($dateRange, $sumColumn);

            // --- Peringkat Kelas ---
            $topKelas = $this->getTopKelas($dateRange, $sumColumn);

            // Ambil rincian sampah HANYA untuk siswa dan kelas yang masuk peringkat
            $this->attachSampahDetails($topSiswa, $dateRange, 'siswa');
            $this->attachSampahDetails($topKelas, $dateRange, 'kelas');
            
            return [
                'topSiswa' => $topSiswa,
                'topKelas' => $topKelas,
            ];
        });

        return view('pages.leaderboard.index', array_merge($data, [
            'filter' => $filter,
            'rankingBy' => $rankingBy,
        ]));
    }

    /**
     * Mengambil data peringkat siswa teratas.
     */
    private function getTopSiswa($dateRange, $sumColumn)
    {
        $orderByColumn = 'setoran_sum_' . $sumColumn;

        return Siswa::query()
            ->whereHas('pengguna', fn($q) => $q->where('role', 'siswa'))
            // <-- PERBAIKAN DI SINI: Menambahkan filter untuk memastikan siswa bukan dari kelas 'Guru'
            ->whereHas('kelas', fn($q) => $q->where('nama_kelas', '!=', 'Guru'))
            ->with(['pengguna', 'kelas'])
            ->withSum(['setoran' => function ($query) use ($dateRange, $sumColumn) {
                if ($dateRange) {
                    $query->whereBetween('created_at', $dateRange);
                }
                $query->where('status', '!=', 'terlambat');
            }], $sumColumn)
            ->having($orderByColumn, '>', 0)
            ->orderByDesc($orderByColumn)
            ->take(5)
            ->get();
    }

    /**
     * Mengambil data peringkat kelas teratas.
     */
    private function getTopKelas($dateRange, $sumColumn)
    {
        // Query ini sudah benar karena secara eksplisit mengecualikan kelas 'Guru'
        return Kelas::query()
            ->where('nama_kelas', '!=', 'Guru')
            ->select('kelas.*')
            ->selectSub(function ($query) use ($sumColumn, $dateRange) {
                $query->selectRaw("SUM({$sumColumn})")
                    ->from('setoran')
                    ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                    ->whereColumn('siswa.id_kelas', 'kelas.id')
                    ->where('setoran.status', '!=', 'terlambat');
                if ($dateRange) {
                    $query->whereBetween('setoran.created_at', $dateRange);
                }
            }, 'total_agregat')
            ->having('total_agregat', '>', 0)
            ->orderByDesc('total_agregat')
            ->take(5)
            ->get();
    }

    /**
     * Mengambil dan melampirkan rincian sampah ke koleksi peringkat.
     */
    private function attachSampahDetails($collection, $dateRange, $type)
    {
        if ($collection->isEmpty()) {
            return;
        }

        $ids = $collection->pluck('id');

        $query = Setoran::join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
            ->select(
                $type === 'siswa' ? 'setoran.siswa_id as relation_id' : 'siswa.id_kelas as relation_id',
                'jenis_sampah.nama_sampah',
                'jenis_sampah.satuan',
                DB::raw('SUM(setoran.jumlah) as total_jumlah')
            )
            ->where('setoran.status', '!=', 'terlambat');

        if ($type === 'kelas') {
            $query->join('siswa', 'setoran.siswa_id', '=', 'siswa.id');
            $query->whereIn('siswa.id_kelas', $ids);
        } else {
            $query->whereIn('setoran.siswa_id', $ids);
        }
        
        if ($dateRange) {
            $query->whereBetween('setoran.created_at', $dateRange);
        }

        $details = $query->groupBy('relation_id', 'jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                         ->orderBy('jenis_sampah.nama_sampah')
                         ->get()
                         ->groupBy('relation_id');

        $collection->each(function ($item) use ($details) {
            $item->sampahDetails = $details->get($item->id, collect());
        });
    }

    private function getDateRange($filter)
    {
        switch ($filter) {
            case 'hari_ini': return [Carbon::now()->startOfDay(), Carbon::now()->endOfDay()];
            case 'minggu_ini': return [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()];
            case 'bulan_ini': return [Carbon::now()->startOfMonth(), Carbon::now()->endOfMonth()];
            case 'bulan_lalu': return [Carbon::now()->subMonth()->startOfMonth(), Carbon::now()->subMonth()->endOfMonth()];
            default: return null;
        }
    }
}