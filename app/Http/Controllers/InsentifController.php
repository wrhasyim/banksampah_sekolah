<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\Pengguna;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;

class InsentifController extends Controller
{
    public function index()
    {
        $insentifs = Insentif::with(['setoran.siswa.pengguna', 'kelas.waliKelas'])->latest()->paginate(15);
        return view('pages.insentif.index', compact('insentifs'));
    }

    public function rekap(Request $request)
    {
        // Tetapkan tanggal default jika tidak ada input
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        // 1. Ambil data Insentif Wali Kelas
        $rekapWaliKelas = Insentif::with('kelas.waliKelas')
            ->whereBetween('created_at', [$start, $end])
            ->whereHas('kelas.waliKelas')
            ->get()
            ->groupBy('kelas.waliKelas.nama_lengkap')
            ->map(function ($items, $namaWaliKelas) {
                return [
                    'nama_wali_kelas' => $namaWaliKelas,
                    'total_insentif' => $items->sum('jumlah_insentif'),
                    'sudah_dibayar' => $items->where('status_pembayaran', 'sudah dibayar')->sum('jumlah_insentif'),
                    'belum_dibayar' => $items->where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif'),
                ];
            })->values();

        // 2. Ambil data Insentif Pengelola
        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])
                                    ->latest('tanggal')
                                    ->paginate(10, ['*'], 'pengelola_page');

        // 3. Ambil data Insentif Sekolah
        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])
                                  ->latest('tanggal')
                                  ->paginate(10, ['*'], 'sekolah_page');
        
        // Hitung total untuk periode yang difilter
        $totalWaliKelas = $rekapWaliKelas->sum('total_insentif');
        $totalPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');
        $totalSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');

        return view('pages.insentif.rekap', compact(
            'rekapWaliKelas',
            'insentifPengelola', 
            'insentifSekolah', 
            'totalWaliKelas',
            'totalPengelola', 
            'totalSekolah', 
            'startDate', 
            'endDate'
        ));
    }

    // Fungsi untuk Ekspor PDF
    public function exportPdf(Request $request)
    {
        // Logika pengambilan data sama, tapi tanpa paginasi
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        $rekapWaliKelas = Insentif::with('kelas.waliKelas')
            ->whereBetween('created_at', [$start, $end])
            ->whereHas('kelas.waliKelas')
            ->get()
            ->groupBy('kelas.waliKelas.nama_lengkap')
            ->map(function ($items, $namaWaliKelas) {
                return [
                    'nama_wali_kelas' => $namaWaliKelas,
                    'total_insentif' => $items->sum('jumlah_insentif'),
                    'sudah_dibayar' => $items->where('status_pembayaran', 'sudah dibayar')->sum('jumlah_insentif'),
                    'belum_dibayar' => $items->where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif'),
                ];
            })->values();

        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])->latest('tanggal')->get();

        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])->latest('tanggal')->get();
        
        $totalWaliKelas = $rekapWaliKelas->sum('total_insentif');
        $totalPengelola = $insentifPengelola->sum('jumlah');
        $totalSekolah = $insentifSekolah->sum('jumlah');

        $pdf = Pdf::loadView('pages.insentif.insentif-rekap-pdf', compact(
            'rekapWaliKelas',
            'insentifPengelola',
            'insentifSekolah',
            'totalWaliKelas',
            'totalPengelola',
            'totalSekolah',
            'startDate',
            'endDate'
        ));

        return $pdf->stream('rekap-insentif-gabungan-' . $startDate . '-sd-' . $endDate . '.pdf');
    }
}