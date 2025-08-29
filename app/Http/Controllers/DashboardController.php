<?php

namespace App\Http\Controllers;

use App\Models\Penjualan;
use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\Penarikan;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\JenisSampah;
use App\Models\Pengguna;

class DashboardController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // Data untuk Kartu Statistik
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            $totalSetoran = Setoran::sum('total_harga');
            $totalPenjualan = Penjualan::sum('total_harga');
            $stokSampah = Setoran::sum('jumlah') - DB::table('detail_penjualan')->sum('jumlah');
            
            // --- ITEM BARU: Menghitung Kas ---
            $totalPenarikanSiswa = Penarikan::sum('jumlah_penarikan');
            $kas = $totalPenjualan - $totalPenarikanSiswa;

            // Data untuk Grafik
            $setoranBulanan = Setoran::select(
                DB::raw('sum(total_harga) as total'),
                DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month")
            )
            ->groupBy('month')
            ->orderBy('month', 'asc')
            ->get();

            $penjualanBulanan = Penjualan::select(
                DB::raw('sum(total_harga) as total'),
                DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month")
            )
            ->groupBy('month')
            ->orderBy('month', 'asc')
            ->get();

            $labels = $setoranBulanan->pluck('month')->merge($penjualanBulanan->pluck('month'))->unique()->sort()->values();
            $dataSetoran = [];
            $dataPenjualan = [];

            foreach ($labels as $label) {
                $setoran = $setoranBulanan->firstWhere('month', $label);
                $dataSetoran[] = $setoran ? $setoran->total : 0;

                $penjualan = $penjualanBulanan->firstWhere('month', $label);
                $dataPenjualan[] = $penjualan ? $penjualan->total : 0;
            }

            // Ambil data total setor dan jual
            $totalSetorPerJenis = Setoran::select('jenis_sampah_id', DB::raw('SUM(jumlah) as total_setor'))
                ->groupBy('jenis_sampah_id')
                ->pluck('total_setor', 'jenis_sampah_id');

            $totalJualPerJenis = DB::table('detail_penjualan')->select('id_jenis_sampah', DB::raw('SUM(jumlah) as total_jual'))
                ->groupBy('id_jenis_sampah')
                ->pluck('total_jual', 'id_jenis_sampah');

            // --- PENYESUAIAN: Ambil semua jenis sampah beserta satuannya ---
            $semuaJenisSampah = JenisSampah::all();
            $stokPerJenis = $semuaJenisSampah->map(function ($jenis) use ($totalSetorPerJenis, $totalJualPerJenis) {
                $setor = $totalSetorPerJenis->get($jenis->id, 0);
                $jual = $totalJualPerJenis->get($jenis->id, 0);
                $stok = $setor - $jual;

                return (object)[
                    'nama' => $jenis->nama,
                    'stok' => $stok,
                    'satuan' => $jenis->satuan, // Mengambil satuan dari model
                ];
            });
            
            // Logika Notifikasi
            $notifikasi = [];
            $sampahMenipis = $stokPerJenis->where('stok', '<', 10);

            if ($sampahMenipis->isNotEmpty()) {
                $notifikasi[] = "Stok untuk " . $sampahMenipis->count() . " jenis sampah menipis. Segera lakukan pengecekan.";
            }

            // Aktivitas Terkini
            $aktivitasTerakhir = [
                'setoran' => Setoran::with('siswa.pengguna')->latest()->take(5)->get(),
                'penjualan' => Penjualan::latest()->take(5)->get(),
                'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(5)->get()
            ];

            return view('dashboard-admin', compact(
                'totalSiswa',
                'totalSaldo',
                'stokSampah',
                'totalSetoran',
                'totalPenjualan',
                'kas', // Variabel baru
                'labels',
                'dataSetoran',
                'dataPenjualan',
                'stokPerJenis',
                'aktivitasTerakhir',
                'notifikasi'
            ));

        } elseif ($user->role === 'siswa') {
            $siswa = $user->siswa;
            $saldo = $siswa->saldo ?? 0;
            $totalSetoran = $siswa->setoran()->sum('total_harga');
            $totalPenarikan = $siswa->penarikan()->sum('jumlah_penarikan');
            $badges = $siswa->badges ?? collect();
            
            return view('dashboard-siswa', compact('saldo', 'totalSetoran', 'totalPenarikan', 'badges'));
        }

        return view('dashboard');
    }
}