<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class LeaderboardController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->get('filter', 'all');
        $now = Carbon::now();

        // Query untuk peringkat siswa (ini sudah benar dari perbaikan sebelumnya)
        $peringkatSiswa = Siswa::with('kelas')
            ->withSum(['setoran as setoran_sum_total' => function ($query) use ($filter, $now) {
                $this->applyDateFilter($query, $filter, $now);
            }], 'total_harga')
            ->orderByDesc('setoran_sum_total')
            ->get();

        // PERBAIKAN: Menggunakan relasi 'setoran' yang baru dari Model Kelas
        $peringkatKelas = Kelas::withSum(['setoran as siswa_setoran_sum_total' => function ($query) use ($filter, $now) {
                $this->applyDateFilter($query, $filter, $now);
            }], 'total_harga')
            ->orderByDesc('siswa_setoran_sum_total')
            ->get();

        return view('pages.leaderboard.index', compact('peringkatSiswa', 'peringkatKelas', 'filter'));
    }

    private function applyDateFilter($query, $filter, $now)
    {
        switch ($filter) {
            case '7':
                $query->whereBetween('created_at', [$now->copy()->subDays(7), $now]);
                break;
            case '30':
                $query->whereBetween('created_at', [$now->copy()->subDays(30), $now]);
                break;
            case 'this_month':
                $query->whereMonth('created_at', $now->month)->whereYear('created_at', $now->year);
                break;
        }
    }
}