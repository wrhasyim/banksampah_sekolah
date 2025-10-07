<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use Illuminate\Support\Facades\Cache; // <--- Tambahkan ini
use Barryvdh\DomPDF\Facade\Pdf;

class RekapanController extends Controller
{
    /**
     * Membuat query dasar untuk laporan siswa terlambat.
     */
    private function getSiswaTerlambatQuery()
    {
        // Eager loading sudah benar, kita pertahankan
        return Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest();
    }

    public function indexSiswaTerlambat(Request $request)
    {
        $currentPage = $request->input('page', 1);
        $cacheKey = 'rekapan_siswa_terlambat_page_' . $currentPage;

        // Menyimpan hasil paginasi ke cache selama 60 menit
        $setoranTerlambat = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTerlambatQuery()->paginate(15);
        });

        return view('pages.rekapan.siswa-terlambat', compact('setoranTerlambat'));
    }

    public function exportSiswaTerlambatPdf()
    {
        $cacheKey = 'export_rekapan_siswa_terlambat';
        
        // Menyimpan seluruh data (tanpa paginasi) ke cache
        $data = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTerlambatQuery()->get();
        });

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-terlambat-pdf', ['data' => $data]);
        return $pdf->download('laporan-rinci-setoran-terlambat-'.date('Y-m-d').'.pdf');
    }
    
    /**
     * Membuat query dasar untuk laporan siswa tanpa wali kelas (tanpa insentif).
     */
    private function getSiswaTanpaWaliKelasQuery()
    {
        return Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest();
    }
    
    public function indexSiswaTanpaWaliKelas(Request $request)
    {
        $currentPage = $request->input('page', 1);
        $cacheKey = 'rekapan_tanpa_wali_kelas_page_' . $currentPage;

        $setoranTanpaWaliKelas = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTanpaWaliKelasQuery()->paginate(15);
        });

        return view('pages.rekapan.siswa-tanpa-wali-kelas', compact('setoranTanpaWaliKelas'));
    }

    public function exportSiswaTanpaWaliKelasPdf()
    {
        $cacheKey = 'export_rekapan_tanpa_wali_kelas';

        $data = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTanpaWaliKelasQuery()->get();
        });

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-tanpa-wali-kelas-pdf', ['data' => $data]);
        return $pdf->download('rekapan-setoran-tanpa-insentif-'.date('Y-m-d').'.pdf');
    }
    
    /**
     * Membuat query dasar untuk laporan setoran guru.
     */
    private function getGuruQuery()
    {
         return Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'like', '%guru%'))
            ->latest();
    }

    public function indexGuru(Request $request)
    {
        $currentPage = $request->input('page', 1);
        $cacheKey = 'rekapan_guru_page_' . $currentPage;

        $setoranGuru = Cache::remember($cacheKey, now()->addMinutes(60), function() {
            return $this->getGuruQuery()->paginate(10);
        });

        return view('pages.rekapan.rekapan-guru', compact('setoranGuru'));
    }

    public function exportGuruPdf()
    {
        $cacheKey = 'export_rekapan_guru';

        $setoranGuru = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getGuruQuery()->get();
        });

        // Proses rekap data tetap di sini, namun sumber datanya sudah dari cache
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