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

        // --- Peringkat Siswa ---
        $topSiswa = Siswa::whereHas('pengguna', function ($query) {
                $query->where('role', 'siswa');
            })
            ->whereHas('kelas', function ($query) {
                $query->where('nama_kelas', '!=', 'Guru');
            })
            ->with('pengguna', 'kelas')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                $query->whereBetween('created_at', $dateRange)
                      ->where('is_terlambat', false); // <-- PERBAIKAN DI SINI
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(5)
            ->get();

        // -- Ambil detail sampah untuk setiap siswa teratas --
        $topSiswa->each(function ($siswa) use ($dateRange) {
            $siswa->sampah_details = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->where('setoran.siswa_id', $siswa->id)
                ->whereBetween('setoran.created_at', $dateRange)
                ->where('setoran.is_terlambat', false) // <-- PERBAIKAN DI SINI
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah')
                ->get();
        });

        // --- Peringkat Kelas ---
        $topKelas = Kelas::where('nama_kelas', '!=', 'Guru')
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange)
                      ->where('is_terlambat', false) // <-- PERBAIKAN DI SINI
                      ->whereHas('siswa.pengguna', function($q) {
                          $q->where('role', 'siswa');
                      });
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(5)
            ->get();
            
        // -- Ambil detail sampah untuk setiap kelas teratas --
        $topKelas->each(function ($kelas) use ($dateRange) {
            $kelas->sampah_details = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                ->where('siswa.id_kelas', $kelas->id)
                ->whereBetween('setoran.created_at', $dateRange)
                ->where('setoran.is_terlambat', false) // <-- PERBAIKAN DI SINI
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah')
                ->get();
        });

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