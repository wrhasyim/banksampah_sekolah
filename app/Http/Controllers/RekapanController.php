<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use Barryvdh\DomPDF\Facade\Pdf;

class RekapanController extends Controller
{
    /**
     * Menampilkan rekapan khusus untuk SISWA.
     */
    public function index(Request $request)
    {
        $querySiswa = function ($query) {
            $query->whereHas('kelas', function ($q) {
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
     * Ekspor PDF untuk rekapan SISWA.
     */
    public function exportSiswaPdf()
    {
        $querySiswa = function ($query) {
            $query->whereHas('kelas', function ($q) {
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

    // ===== BAGIAN REKAPAN GURU YANG DIPERBARUI =====

    /**
     * Menampilkan rekapan setoran GURU yang disederhanakan.
     */
    public function indexGuru(Request $request)
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            })
            ->latest()
            ->paginate(10); // Menampilkan 10 data per halaman

        return view('pages.rekapan.rekapan-guru', compact('setoranGuru'));
    }

    /**
     * Ekspor PDF untuk semua setoran GURU.
     */
    public function exportGuruPdf()
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            })
            ->latest()
            ->get();

        $pdf = Pdf::loadView('pages.rekapan.rekapan-guru-pdf', ['setoranGuru' => $setoranGuru]);
        return $pdf->download('rekapan-setoran-guru-'.date('Y-m-d').'.pdf');
    }
}