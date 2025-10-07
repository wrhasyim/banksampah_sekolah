<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Pengguna;
use Barryvdh\DomPDF\Facade\Pdf;

class RekapanController extends Controller
{
    public function indexSiswaTerlambat(Request $request)
    {
        $setoranTerlambat = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat') 
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest()
            ->paginate(15);

        return view('pages.rekapan.siswa-terlambat', compact('setoranTerlambat'));
    }

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
    
    public function exportSiswaTerlambatPdf()
    {
        $data = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest()->get();

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-terlambat-pdf', ['data' => $data]);
        return $pdf->download('laporan-rinci-setoran-terlambat-'.date('Y-m-d').'.pdf');
    }

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
    
    public function indexGuru(Request $request)
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'like', '%guru%'))
            ->latest()
            ->paginate(10);

        return view('pages.rekapan.rekapan-guru', compact('setoranGuru'));
    }

    public function exportGuruPdf()
    {
        $setoranGuru = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', function ($q) {
                $q->where('nama_kelas', 'like', '%guru%');
            })
            ->latest()
            ->get();

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