<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request; // Tambahkan ini
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    // Tambahkan Request $request ke dalam parameter metode index
    public function index(Request $request)
    {
        $user = Auth::user();

        if ($user->role === 'admin') {
            // --- LOGIKA BARU UNTUK FILTER DINAMIS ---
            $jangkaWaktu = $request->input('jangka_waktu', '7'); // Default 7 hari
            $tipeGrafik = $request->input('tipe_grafik', 'nominal'); // Default nominal (Rp)

            // Tentukan kolom yang akan di-SUM berdasarkan tipe grafik
            $kolomAgregat = $tipeGrafik === 'jumlah' ? 'jumlah_satuan' : 'total_harga';
            
            // Tentukan rentang tanggal
            $tanggalMulai = now();
            if ($jangkaWaktu === '30') {
                $tanggalMulai = now()->subDays(29);
            } elseif ($jangkaWaktu === 'bulan_ini') {
                $tanggalMulai = now()->startOfMonth();
            } else { // Default 7 hari
                $tanggalMulai = now()->subDays(6);
            }

            // Data untuk Grafik Dinamis
            $setoranTerakhir = Setoran::select(DB::raw('DATE(created_at) as tanggal'), DB::raw("SUM($kolomAgregat) as total"))
                ->where('created_at', '>=', $tanggalMulai)
                ->groupBy('tanggal')
                ->orderBy('tanggal', 'asc')
                ->get();

            // Format data untuk Chart.js
            $labels = $setoranTerakhir->map(fn($item) => \Carbon\Carbon::parse($item->tanggal)->format('d M'));
            $data = $setoranTerakhir->map(fn($item) => $item->total);

            $chartData = [
                'labels' => $labels,
                'data' => $data,
                'label' => $tipeGrafik === 'jumlah' ? 'Jumlah Sampah (pcs)' : 'Total Setoran (Rp)',
            ];
            // --- AKHIR LOGIKA BARU ---

            // Data Ringkasan (tetap sama)
            $totalSiswa = Siswa::count();
            $totalSaldo = Siswa::sum('saldo');
            $totalSetoranHariIni = Setoran::whereDate('created_at', today())->sum('total_harga');
            
            // Data Peringkat (tetap sama)
            $peringkatSiswa = Siswa::select('id_pengguna', DB::raw('SUM(setoran.jumlah_satuan) as total_satuan'))
                ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->with('pengguna')->groupBy('id_pengguna')->orderByDesc('total_satuan')->limit(5)->get();
            $peringkatKelas = Kelas::select('nama_kelas', DB::raw('SUM(setoran.jumlah_satuan) as total_satuan'))
                ->join('siswa', 'kelas.id', '=', 'siswa.id_kelas')->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
                ->groupBy('nama_kelas')->orderByDesc('total_satuan')->limit(5)->get();
            
            return view('dashboard-admin', compact(
                'totalSiswa', 'totalSaldo', 'totalSetoranHariIni', 'peringkatSiswa', 
                'peringkatKelas', 'chartData', 'jangkaWaktu', 'tipeGrafik' // Kirim nilai filter ke view
            ));

        } 
        // ... (sisa kode untuk siswa tetap sama)
    }
}