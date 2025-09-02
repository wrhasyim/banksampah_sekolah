<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use Barryvdh\DomPDF\Facade\Pdf; // Import PDF Facade

class RekapanController extends Controller
{
    /**
     * Menampilkan rekapan khusus untuk SISWA.
     */
    public function index(Request $request)
    {
        // Query dasar untuk mengambil data setoran siswa (bukan guru)
        $querySiswa = function ($query) {
            $query->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'not like', '%guru%');
            });
        };

        $setoranTerlambat = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa', $querySiswa)
            ->latest()
            ->paginate(5, ['*'], 'terlambat_page');

        $setoranTanpaWaliKelas = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa', $querySiswa)
            ->latest()
            ->paginate(5, ['*'], 'tanpa_wali_kelas_page');

        return view('pages.rekapan.index', compact('setoranTerlambat', 'setoranTanpaWaliKelas'));
    }

    /**
     * Menampilkan rekapan khusus untuk GURU.
     */
    public function indexGuru(Request $request)
    {
        // Query dasar untuk mengambil data setoran guru
        $queryGuru = function ($query) {
            $query->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            });
        };
        
        $setoranTerlambatGuru = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa', $queryGuru)
            ->latest()
            ->paginate(5, ['*'], 'terlambat_page');

        $setoranTanpaWaliKelasGuru = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa', $queryGuru)
            ->latest()
            ->paginate(5, ['*'], 'tanpa_wali_kelas_page');

        return view('pages.rekapan.rekapan-guru', compact('setoranTerlambatGuru', 'setoranTanpaWaliKelasGuru'));
    }


    /**
     * Ekspor PDF untuk rekapan SISWA.
     */
    public function exportSiswaPdf()
    {
        $querySiswa = function ($query) {
            $query->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'not like', '%guru%');
            });
        };

        $data['setoranTerlambat'] = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa', $querySiswa)
            ->latest()->get();

        $data['setoranTanpaWaliKelas'] = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa', $querySiswa)
            ->latest()->get();

        $pdf = Pdf::loadView('pages.rekapan.rekapan-pdf', ['data' => $data, 'title' => 'Rekapan Khusus Siswa']);
        return $pdf->download('rekapan-khusus-siswa-'.date('Y-m-d').'.pdf');
    }

    /**
     * Ekspor PDF untuk rekapan GURU.
     */
    public function exportGuruPdf()
    {
        $queryGuru = function ($query) {
            $query->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            });
        };

        $data['setoranTerlambat'] = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa', $queryGuru)
            ->latest()->get();

        $data['setoranTanpaWaliKelas'] = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa', $queryGuru)
            ->latest()->get();

        $pdf = Pdf::loadView('pages.rekapan.rekapan-pdf', ['data' => $data, 'title' => 'Rekapan Khusus Guru']);
        return $pdf->download('rekapan-khusus-guru-'.date('Y-m-d').'.pdf');
    }
}