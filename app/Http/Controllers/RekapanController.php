<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use Illuminate\Support\Facades\DB;

class RekapanController extends Controller
{
    public function index(Request $request)
    {
        // 1. Ambil data siswa yang terlambat dengan paginasi 5 data per halaman
        $setoranTerlambat = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->latest()
            ->paginate(5, ['*'], 'terlambat_page'); // Menambahkan nama halaman kustom

        // 2. Ambil data setoran tanpa wali kelas dengan paginasi 5 data per halaman
        $setoranTanpaWaliKelas = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->latest()
            ->paginate(5, ['*'], 'tanpa_wali_kelas_page'); // Menambahkan nama halaman kustom

        return view('pages.rekapan.index', compact('setoranTerlambat', 'setoranTanpaWaliKelas'));
    }
}