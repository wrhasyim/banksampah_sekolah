<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Setoran; // Ditambahkan untuk query yang lebih eksplisit
use App\Models\Pengguna;
use Barryvdh\DomPDF\Facade\Pdf;

class RekapanController extends Controller
{
    /**
     * Menampilkan rekapan rinci setoran terlambat.
     */
    public function indexSiswaTerlambat(Request $request)
    {
        // Query diubah untuk mengambil semua detail setoran, bukan lagi summary
        $setoranTerlambat = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest() // Urutkan berdasarkan yang terbaru
            ->paginate(15); // Menggunakan paginasi

        return view('pages.rekapan.siswa-terlambat', compact('setoranTerlambat'));
    }

    /**
     * Menampilkan rekapan setoran yang tidak mendapat insentif.
     */
    public function indexSiswaTanpaWaliKelas(Request $request)
    {
        $setoranTanpaWaliKelas = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest()
            ->paginate(15);

        return view('pages.rekapan.siswa-tanpa-wali-kelas', compact('setoranTanpaWaliKelas'));
    }
    
    /**
     * Ekspor PDF untuk laporan rinci setoran terlambat.
     */
    public function exportSiswaTerlambatPdf()
    {
        // Query diubah untuk mengambil semua detail setoran
        $data = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest()->get();

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-terlambat-pdf', ['data' => $data]);
        return $pdf->download('laporan-rinci-setoran-terlambat-'.date('Y-m-d').'.pdf');
    }

    /**
     * Ekspor PDF untuk setoran tanpa insentif.
     */
    public function exportSiswaTanpaWaliKelasPdf()
    {
        $data = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest()->get();

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-tanpa-wali-kelas-pdf', ['data' => $data]);
        return $pdf->download('rekapan-setoran-tanpa-insentif-'.date('Y-m-d').'.pdf');
    }


    // ====== FUNGSI UNTUK REKAPAN GURU (TIDAK BERUBAH) ======
    
    public function indexGuru(Request $request)
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'like', '%guru%'))
            ->latest()
            ->paginate(10);

        return view('pages.rekapan.rekapan-guru', compact('setoranGuru'));
    }

    /**
     * Ekspor PDF untuk semua setoran GURU dengan rekapitulasi.
     */
    public function exportGuruPdf()
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            })
            ->latest()
            ->get();

        // Mengelompokkan data berdasarkan guru
        $rekapData = [];
        foreach ($setoranGuru as $setoran) {
            $guruId = $setoran->siswa->id;
            $namaGuru = $setoran->siswa->pengguna->nama_lengkap;

            if (!isset($rekapData[$guruId])) {
                $rekapData[$guruId] = [
                    'nama_guru' => $namaGuru,
                    'total_harga' => 0,
                    'sampah' => [],
                ];
            }

            $rekapData[$guruId]['total_harga'] += $setoran->total_harga;

            $jenisSampah = $setoran->jenisSampah->nama_sampah;
            $satuan = $setoran->jenisSampah->satuan;
            if (!isset($rekapData[$guruId]['sampah'][$jenisSampah])) {
                $rekapData[$guruId]['sampah'][$jenisSampah] = [
                    'jumlah' => 0,
                    'satuan' => $satuan,
                ];
            }
            $rekapData[$guruId]['sampah'][$jenisSampah]['jumlah'] += $setoran->jumlah;
        }

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-guru-summary-pdf', ['rekapData' => $rekapData]);
        return $pdf->download('rekapitulasi-setoran-guru-'.date('Y-m-d').'.pdf');
    }
}