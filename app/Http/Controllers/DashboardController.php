<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Penjualan;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // Data Ringkasan
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            $totalSetoranHariIni = Setoran::whereDate('created_at', today())->sum('total_harga');
            $totalPenjualan = Penjualan::sum('total_harga');

            // --- QUERY PENJUALAN TERAKHIR DIPERBAIKI DI SINI ---
            // Hapus withSum untuk jumlah_kg yang sudah tidak ada
            $penjualanTerakhir = Penjualan::with('admin')
                ->withSum('detailPenjualan', 'jumlah')
                ->latest()
                ->take(5)
                ->get();
            
            // Logika Grafik Dinamis
            $jangkaWaktu = $request->input('jangka_waktu', '7');
            $tipeGrafik = $request->input('tipe_grafik', 'nominal');
            $kolomAgregat = $tipeGrafik === 'jumlah' ? 'jumlah' : 'total_harga';
            $tanggalMulai = now();
            if ($jangkaWaktu === '30') {
                $tanggalMulai = now()->subDays(29);
            } elseif ($jangkaWaktu === 'bulan_ini') {
                $tanggalMulai = now()->startOfMonth();
            } else {
                $tanggalMulai = now()->subDays(6);
            }
            $setoranTerakhir = Setoran::select(DB::raw('DATE(created_at) as tanggal'), DB::raw("SUM($kolomAgregat) as total"))
                ->where('created_at', '>=', $tanggalMulai)
                ->groupBy('tanggal')->orderBy('tanggal', 'asc')->get();
            $labels = $setoranTerakhir->map(fn($item) => \Carbon\Carbon::parse($item->tanggal)->format('d M'));
            $data = $setoranTerakhir->map(fn($item) => $item->total);
            $chartData = [
                'labels' => $labels, 'data' => $data,
                'label' => $tipeGrafik === 'jumlah' ? 'Jumlah Sampah' : 'Total Setoran (Rp)',
            ];

            // Panggil Peringkat Menggunakan Scope
            $peringkatSiswa = Siswa::peringkatTeraktif()->get();
            $peringkatKelas = Kelas::peringkatTeraktif()->get();
            
            return view('dashboard-admin', compact(
                'totalSiswa', 'totalSaldo', 'totalSetoranHariIni', 'totalPenjualan', 'penjualanTerakhir',
                'peringkatSiswa', 'peringkatKelas', 'chartData', 'jangkaWaktu', 'tipeGrafik'
            ));

        } elseif ($user->role === 'siswa') {
            $siswa = $user->siswa;
            if (!$siswa) {
                Auth::logout();
                return redirect('/login')->with('error', 'Data siswa tidak ditemukan. Silakan hubungi admin.');
            }
            
            $setoran = $siswa->setoran()->with('jenisSampah')->latest()->take(5)->get()->map(fn($i) => ['tipe' => 'setoran', 'data' => $i]);
            $penarikan = $siswa->penarikan()->latest()->take(5)->get()->map(fn($i) => ['tipe' => 'penarikan', 'data' => $i]);

            $transaksiTerakhir = $setoran->concat($penarikan)
                                ->sortByDesc(fn($i) => $i['data']->created_at)
                                ->take(5);

            return view('dashboard-siswa', compact('siswa', 'transaksiTerakhir'));
        }
        
        return view('dashboard');
    }
}