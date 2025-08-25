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
            $penjualanTerakhir = Penjualan::with('admin')
                ->withSum('detailPenjualan', 'jumlah')
                ->withSum('detailPenjualan', 'jumlah_kg')
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
                'labels' => $labels,
                'data' => $data,
                'label' => $tipeGrafik === 'jumlah' ? 'Jumlah Sampah' : 'Total Setoran (Rp)',
            ];

            // --- LOGIKA PERINGKAT YANG DIKEMBALIKAN ---
            $peringkatSiswa = Siswa::select('id_pengguna', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->with('pengguna')
                ->groupBy('id_pengguna')
                ->orderByDesc('total_jumlah')
                ->limit(5)
                ->get();

            $peringkatKelas = Kelas::select('nama_kelas', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
                ->join('siswa', 'kelas.id', '=', 'siswa.id_kelas')
                ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->groupBy('nama_kelas')
                ->orderByDesc('total_jumlah')
                ->limit(5)
                ->get();
            
            return view('dashboard-admin', compact(
                'totalSiswa', 'totalSaldo', 'totalSetoranHariIni', 'totalPenjualan', 'penjualanTerakhir',
                'peringkatSiswa', 'peringkatKelas', 'chartData', 'jangkaWaktu', 'tipeGrafik'
            ));

        } elseif ($user->role === 'siswa') {
            // ... (logika untuk siswa tidak berubah)
        }
        
        return view('dashboard');
    }
}