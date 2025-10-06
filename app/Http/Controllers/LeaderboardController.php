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
        $rankingBy = $request->input('ranking_by', 'nominal'); // Filter baru
        $dateRange = $this->getDateRange($filter);

        // Tentukan kolom yang akan di-SUM dan di-ORDER BY
        $sumColumn = ($rankingBy === 'jumlah') ? 'jumlah' : 'total_harga';
        $orderByColumn = 'setoran_sum_' . $sumColumn;

        // --- Peringkat Siswa ---
        $topSiswa = Siswa::whereHas('pengguna', fn($q) => $q->where('role', 'siswa'))
            ->whereHas('kelas', fn($q) => $q->where('nama_kelas', '!=', 'Guru'))
            ->with('pengguna', 'kelas')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('created_at', $dateRange);
                }
                $query->where('is_terlambat', false);
            }], $sumColumn) // Menggunakan $sumColumn dinamis
            ->orderByDesc($orderByColumn) // Menggunakan $orderByColumn dinamis
            ->take(5)
            ->get();

        // -- Ambil detail sampah untuk setiap siswa teratas (logika tidak berubah)--
        $topSiswa->each(function ($siswa) use ($dateRange) {
            $query = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->where('setoran.siswa_id', $siswa->id)
                ->where('setoran.is_terlambat', false)
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah');
            
            if ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange);
            }
            
            $siswa->sampah_details = $query->get();
        });

        // --- Peringkat Kelas ---
        $topKelas = Kelas::where('nama_kelas', '!=', 'Guru')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('setoran.created_at', $dateRange);
                }
                $query->where('is_terlambat', false)
                      ->whereHas('siswa.pengguna', fn($q) => $q->where('role', 'siswa'));
            }], $sumColumn) // Menggunakan $sumColumn dinamis
            ->orderByDesc($orderByColumn) // Menggunakan $orderByColumn dinamis
            ->take(5)
            ->get();
            
        // -- Ambil detail sampah untuk setiap kelas teratas (logika tidak berubah) --
        $topKelas->each(function ($kelas) use ($dateRange) {
            $query = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                ->where('siswa.id_kelas', $kelas->id)
                ->where('setoran.is_terlambat', false)
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
            'rankingBy' => $rankingBy, // Kirim filter baru ke view
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