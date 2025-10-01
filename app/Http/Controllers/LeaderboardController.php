<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Siswa;
use App\Models\Badge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon; // Pastikan Carbon di-import

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        // [MODIFIKASI] Mengubah default filter menjadi 'semua_waktu' agar lebih umum
        $filter = $request->input('filter', 'semua_waktu');
        $dateRange = $this->getDateRange($filter);

        // --- Peringkat Siswa ---
        $topSiswa = Siswa::whereHas('pengguna', function ($query) {
                $query->where('role', 'siswa');
            })
            ->whereHas('kelas', function ($query) {
                $query->where('nama_kelas', '!=', 'Guru');
            })
            ->with('pengguna', 'kelas')
            // [MODIFIKASI] Query withSum dibuat kondisional
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('created_at', $dateRange);
                }
                $query->where('is_terlambat', false);
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(5)
            ->get();

        // -- Ambil detail sampah untuk setiap siswa teratas --
        $topSiswa->each(function ($siswa) use ($dateRange) {
            $query = DB::table('setoran')
                ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
                ->where('setoran.siswa_id', $siswa->id)
                ->where('setoran.is_terlambat', false)
                ->select('jenis_sampah.nama_sampah as nama_jenis', 'jenis_sampah.satuan', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->groupBy('jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
                ->havingRaw('SUM(setoran.jumlah) >= 1')
                ->orderBy('jenis_sampah.nama_sampah');
            
            // [MODIFIKASI] Query detail sampah dibuat kondisional
            if ($dateRange) {
                $query->whereBetween('setoran.created_at', $dateRange);
            }
            
            $siswa->sampah_details = $query->get();
        });

        // --- Peringkat Kelas ---
        $topKelas = Kelas::where('nama_kelas', '!=', 'Guru')
            // [MODIFIKASI] Query withSum dibuat kondisional
            ->withSum(['setoran' => function ($query) use ($dateRange) {
                if ($dateRange) {
                    $query->whereBetween('setoran.created_at', $dateRange);
                }
                $query->where('is_terlambat', false)
                    ->whereHas('siswa.pengguna', function($q) {
                        $q->where('role', 'siswa');
                    });
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total_harga')
            ->take(5)
            ->get();
            
        // -- Ambil detail sampah untuk setiap kelas teratas --
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

            // [MODIFIKASI] Query detail sampah dibuat kondisional
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
            'badges' => $badges,
        ]);
    }

    private function getDateRange($filter)
    {
        // [MODIFIKASI] Menyesuaikan dengan daftar filter yang baru
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
                return null; // Akan diabaikan oleh query
            default:
                // Default filter jika tidak ada yang dipilih
                return null;
        }
    }
}