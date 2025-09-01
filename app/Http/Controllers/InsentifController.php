<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas;
use Illuminate\Http\Request;
use Carbon\Carbon;

class InsentifController extends Controller
{
    public function index()
    {
        // Mengurutkan dari yang terbaru dan menambahkan paginasi
        // Ganti 'penjualan' menjadi 'setoran.siswa.pengguna'
        $insentifs = Insentif::with(['setoran.siswa.pengguna', 'kelas.waliKelas'])->latest()->paginate(15);
        return view('pages.insentif.index', compact('insentifs'));
    }

    // ... (method rekap tidak berubah) ...
    public function rekap(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        // --- PERBAIKAN DI SINI: Menggunakan latest() untuk mengurutkan ---
        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])
                                    ->latest('tanggal') // Mengurutkan dari tanggal terbaru
                                    ->paginate(5, ['*'], 'pengelola_page');

        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])
                                  ->latest('tanggal') // Mengurutkan dari tanggal terbaru
                                  ->paginate(5, ['*'], 'sekolah_page');
        
        $totalPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');
        $totalSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');

        return view('pages.insentif.rekap', compact('insentifPengelola', 'insentifSekolah', 'totalPengelola', 'totalSekolah', 'startDate', 'endDate'));
    }
}