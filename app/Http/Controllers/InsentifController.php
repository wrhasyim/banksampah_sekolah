<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas; // Import model BukuKas
use Illuminate\Http\Request;
use Carbon\Carbon; // Import Carbon

class InsentifController extends Controller
{
    // Halaman untuk insentif Wali Kelas (tidak berubah)
    public function index()
    {
        $insentifs = Insentif::with('penjualan', 'kelas.waliKelas')->latest()->get();
        return view('pages.insentif.index', compact('insentifs'));
    }

    // --- METHOD BARU UNTUK REKAP PENGELOLA & SEKOLAH ---
    public function rekap(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        // Ambil data honor Pengelola dari Buku Kas
        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])
                                    ->get();

        // Ambil data honor Sekolah dari Buku Kas
        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])
                                  ->get();
        
        // Hitung total untuk ditampilkan di ringkasan
        $totalPengelola = $insentifPengelola->sum('jumlah');
        $totalSekolah = $insentifSekolah->sum('jumlah');

        return view('pages.insentif.rekap', compact('insentifPengelola', 'insentifSekolah', 'totalPengelola', 'totalSekolah', 'startDate', 'endDate'));
    }
}