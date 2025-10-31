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
    /**
     * ========================================================================
     * FUNGSI INDEX (DIMODIFIKASI)
     * Mengganti $filter dengan $tanggal_mulai dan $tanggal_akhir
     * ========================================================================
     */
    public function index(Request $request)
    {
        // 1. Ambil input tanggal. 
        // Default: Tanggal 1 bulan ini s/d hari ini.
        $tanggal_mulai = $request->input('tanggal_mulai', Carbon::now()->startOfMonth()->toDateString());
        $tanggal_akhir = $request->input('tanggal_akhir', Carbon::now()->toDateString()); // Default-nya hari ini

        // 2. Ambil input urutan (ini tetap ada)
        $rankingBy = $request->input('ranking_by', 'jumlah');
        
        // 3. Buat cache key yang unik berdasarkan SEMUA filter
        $cacheKey = 'leaderboard_hybrid:' . $rankingBy . ':' . $tanggal_mulai . '_to_' . $tanggal_akhir;

        // 4. Gunakan Cache
        $data = Cache::remember($cacheKey, now()->addMinutes(15), function () use ($rankingBy, $tanggal_mulai, $tanggal_akhir) {
            
            // 5. Buat array dateRange yang akan digunakan oleh helper
            // Kita tambahkan waktu agar query 'between' akurat
            $dateRange = [
                $tanggal_mulai . " 00:00:00",
                $tanggal_akhir . " 23:59:59"
            ];
            
            $sumColumn = ($rankingBy === 'jumlah') ? 'jumlah' : 'total_harga';

            // --- Peringkat Siswa ---
            $topSiswa = $this->getTopSiswa($dateRange, $sumColumn);

            // --- Peringkat Kelas ---
            $topKelas = $this->getTopKelas($dateRange, $sumColumn);

            // Ambil rincian sampah HANYA untuk siswa dan kelas yang masuk peringkat
            $this->attachSampahDetails($topSiswa, $dateRange, 'siswa');
            
            // --- PERBAIKAN BUG DI SINI ---
            // Menambahkan '$this->' yang hilang
            $this->attachSampahDetails($topKelas, $dateRange, 'kelas');
            // --- AKHIR PERBAIKAN ---
            
            return [
                'topSiswa' => $topSiswa,
                'topKelas' => $topKelas,
            ];
        });

        // 6. Kembalikan data ke view
        return view('pages.leaderboard.index', array_merge($data, [
            'rankingBy' => $rankingBy,
            'tanggal_mulai' => $tanggal_mulai, // Kirim ke view
            'tanggal_akhir' => $tanggal_akhir, // Kirim ke view
        ]));
    }

    /**
     * Mengambil data peringkat siswa teratas.
     * (FUNGSI INI TIDAK DIUBAH)
     */
    private function getTopSiswa($dateRange, $sumColumn)
    {
        $orderByColumn = 'setoran_sum_' . $sumColumn;

        return Siswa::query()
            ->whereHas('pengguna', fn($q) => $q->where('role', 'siswa'))
            ->whereHas('kelas', fn($q) => $q->where('nama_kelas', '!=', 'Guru'))
            ->with(['pengguna', 'kelas'])
            ->withSum(['setoran' => function ($query) use ($dateRange, $sumColumn) {
                if ($dateRange) { // <-- Logika ini sudah benar
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
     * (FUNGSI INI TIDAK DIUBAH)
     */
    private function getTopKelas($dateRange, $sumColumn)
    {
        return Kelas::query()
            ->where('nama_kelas', '!=', 'Guru')
            ->select('kelas.*')
            ->selectSub(function ($query) use ($sumColumn, $dateRange) {
                $query->selectRaw("SUM({$sumColumn})")
                    ->from('setoran')
                    ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                    ->whereColumn('siswa.id_kelas', 'kelas.id')
                    ->where('setoran.status', '!=', 'terlambat');
                if ($dateRange) { // <-- Logika ini sudah benar
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
     * (FUNGSI INI TIDAK DIUBAH)
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
        
        if ($dateRange) { // <-- Logika ini sudah benar
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
}