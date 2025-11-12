<?php

namespace App\Http\Controllers;

// Model yang sudah ada di file Anda
use App\Models\JenisSampah;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\BukuKas;
use App\Models\Insentif;

// Model yang ditambahkan untuk dashboard siswa & wali
use App\Models\Badge; 
use Illuminate\Support\Facades\Auth; 

// Fasilitas yang sudah ada di file Anda
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class DashboardController extends Controller
{
    /**
     * ========================================================================
     * FUNGSI INDEX (DIMODIFIKASI UNTUK ROLE-BASED)
     * ========================================================================
     * */
    public function index()
    {
        $user = Auth::user();

        // =================================================================
        // 1. LOGIKA UNTUK ADMIN (Tidak Diubah)
        // =================================================================
        if ($user->role === 'admin') {
            $dashboardData = Cache::remember('admin_dashboard_data', now()->addMinutes(10), function () {
                
                $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();
                $nilaiStokJual = JenisSampah::sum(DB::raw('stok * harga_jual'));
                $modalStokBeli = JenisSampah::sum(DB::raw('stok * harga_per_satuan'));
                $kas = BukuKas::where('tipe', 'pemasukan')->sum('jumlah') - BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
                $totalInsentifBelumDibayar = Insentif::where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif');

                // --- DATA SISWA (DENGAN FILTER GURU) ---
                $totalSiswa = Siswa::whereHas('kelas', function ($query) {
                    $query->where('nama_kelas', '!=', 'Guru');
                })->count();

                $totalSetoranSiswa = Setoran::whereHas('siswa.kelas', function ($query) {
                    $query->where('nama_kelas', '!=', 'Guru');
                })->sum('total_harga');
                
                $totalPenarikanSiswa = Penarikan::whereHas('siswa.kelas', function ($query) {
                    $query->where('nama_kelas', '!=', 'Guru');
                })->sum('jumlah_penarikan');

                $siswaAktifBulanIni = Setoran::where('created_at', '>=', now()->subMonth())
                                            ->whereHas('siswa.kelas', function ($query) {
                                                $query->where('nama_kelas', '!=', 'Guru');
                                            })
                                            ->distinct('siswa_id')
                                            ->count('siswa_id');

                // --- PENAMBAHAN QUERY UNTUK STATISTIK GURU ---
                $totalGuru = Siswa::whereHas('kelas', function ($query) {
                    $query->where('nama_kelas', 'Guru');
                })->count();

                $totalSetoranGuru = Setoran::whereHas('siswa.kelas', function ($query) {
                    $query->where('nama_kelas', 'Guru');
                })->sum('total_harga');

                $totalPenarikanGuru = Penarikan::whereHas('siswa.kelas', function ($query) {
                    $query->where('nama_kelas', 'Guru');
                })->sum('jumlah_penarikan');

                $guruAktifBulanIni = Setoran::where('created_at', '>=', now()->subMonth())
                                            ->whereHas('siswa.kelas', function ($query) {
                                                $query->where('nama_kelas', 'Guru');
                                            })
                                            ->distinct('siswa_id')
                                            ->count('siswa_id');

                // --- DATA KEUANGAN BULAN INI ---
                $bulanIni = now()->month;
                $tahunIni = now()->year;
                $pemasukanBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pemasukan')->sum('jumlah');
                $pengeluaranBulanIni = BukuKas::whereYear('tanggal', $tahunIni)->whereMonth('tanggal', $bulanIni)->where('tipe', 'pengeluaran')->sum('jumlah');
                $labaBersihBulanIni = $pemasukanBulanIni - $pengeluaranBulanIni;

                $aktivitasTerakhir = [
                    'setoran' => Setoran::with('siswa.pengguna')->latest()->take(5)->get(),
                    'penarikan' => Penarikan::with('siswa.pengguna')->latest()->take(5)->get(),
                ];
                
                return [
                    'totalSiswa' => $totalSiswa, 
                    'kas' => $kas,
                    'nilaiStokJual' => $nilaiStokJual,
                    'modalStokBeli' => $modalStokBeli,
                    'totalInsentifBelumDibayar' => $totalInsentifBelumDibayar,
                    'stokPerJenis' => $semuaJenisSampah,
                    'aktivitasTerakhir' => $aktivitasTerakhir,
                    'labaBersihBulanIni' => $labaBersihBulanIni,
                    'totalSetoranSiswa' => $totalSetoranSiswa,
                    'totalPenarikanSiswa' => $totalPenarikanSiswa,
                    'siswaAktifBulanIni' => $siswaAktifBulanIni,
                    // --- Menambahkan data guru untuk view ---
                    'totalGuru' => $totalGuru,
                    'totalSetoranGuru' => $totalSetoranGuru,
                    'totalPenarikanGuru' => $totalPenarikanGuru,
                    'guruAktifBulanIni' => $guruAktifBulanIni,
                ];
            });

            return view('dashboard-admin', $dashboardData);
        
        // =================================================================
        // 2. LOGIKA UNTUK SISWA (MENGGUNAKAN PAGINATE)
        // =================================================================
        } elseif ($user->role === 'siswa') {
            $siswa = $user->siswa;
            
            if (!$siswa) { 
                Auth::logout();
                return redirect()->route('login')->with('toastr-error', 'Data siswa Anda tidak ditemukan. Harap hubungi admin.');
            }
            
            $setoranSiswa = $siswa->setoran();

            // --- PERUBAHAN DI BARIS INI ---
            // Mengganti take(5)->get() menjadi paginate(5)
            $setoranTerakhir = $setoranSiswa->with('jenisSampah')->latest()->paginate(5);
            // --- AKHIR PERUBAHAN ---
            
            $totalBeratSetoran = $siswa->setoran()->sum('jumlah');
            $totalFrekuensiSetoran = $siswa->setoran()->count();
            
            return view('dashboard-siswa', compact(
                'siswa', 
                'setoranTerakhir',
                'totalBeratSetoran',
                'totalFrekuensiSetoran'
            ));

        // =================================================================
        // 3. LOGIKA UNTUK WALI KELAS (Tidak Diubah)
        // =================================================================
        } elseif ($user->role === 'wali') {
            
            $kelas = $user->kelasYangDiampu; 

            if ($kelas) {
                $kelas->load('siswa');
                $siswaIds = $kelas->siswa->pluck('id');
                $jumlahSiswa = $kelas->siswa->count();
                $totalSetoran = Setoran::whereIn('siswa_id', $siswaIds)->sum('total_harga');
                $totalPenarikan = Penarikan::whereIn('siswa_id', $siswaIds)->sum('jumlah_penarikan');
                $saldoKelas = $totalSetoran - $totalPenarikan;
                $setoranTerakhir = Setoran::whereIn('siswa_id', $siswaIds)
                                        ->with('siswa.pengguna', 'jenisSampah') 
                                        ->latest()
                                        ->take(5)
                                        ->get();
                
                return view('dashboard-wali', compact(
                    'kelas', 
                    'saldoKelas', 
                    'totalSetoran', 
                    'totalPenarikan', 
                    'setoranTerakhir', 
                    'jumlahSiswa'
                ));

            } else {
                return view('dashboard-wali-nokelas');
            }
        
        // =================================================================
        // 4. FALLBACK (Tidak Diubah)
        // =================================================================
        }

        return redirect()->route('login');
    }

    /**
     * ========================================================================
     * FUNGSI CHART (TIDAK DIUBAH)
     * ========================================================================
     */
    public function getChartData(Request $request)
    {
        // ... (Fungsi ini tetap sama) ...
        $period = $request->input('period', 'monthly');
        $cacheKey = 'dashboard_chart_data:' . $period;

        $chartData = Cache::remember($cacheKey, now()->addMinutes(10), function () use ($period) {
            $labels = [];
            $dataSetoran = [];
            $dataPenjualan = [];

            if ($period == 'monthly') {
                $format = '%Y-%m';
                $startDate = now()->subMonths(5)->startOfMonth();

                $setoranData = Setoran::where('created_at', '>=', $startDate)
                    ->selectRaw("DATE_FORMAT(created_at, '$format') as date, SUM(total_harga) as total")
                    ->groupBy('date')
                    ->pluck('total', 'date');

                $penjualanData = Penjualan::where('created_at', '>=', $startDate)
                    ->selectRaw("DATE_FORMAT(created_at, '$format') as date, SUM(total_harga) as total")
                    ->groupBy('date')
                    ->pluck('total', 'date');
                
                for ($i = 5; $i >= 0; $i--) {
                    $date = now()->subMonths($i);
                    $label = $date->format('M Y');
                    $key = $date->format('Y-m');
                    
                    $labels[] = $label;
                    $dataSetoran[$key] = 0;
                    $dataPenjualan[$key] = 0;
                }

                foreach ($setoranData as $date => $total) {
                    $dataSetoran[$date] = $total;
                }
                foreach ($penjualanData as $date => $total) {
                    $dataPenjualan[$date] = $total;
                }

            } else { // Daily
                $format = '%Y-%m-%d';
                $startDate = now()->subDays(6)->startOfDay();

                $setoranData = Setoran::where('created_at', '>=', $startDate)
                    ->selectRaw("DATE_FORMAT(created_at, '$format') as date, SUM(total_harga) as total")
                    ->groupBy('date')
                    ->pluck('total', 'date');

                $penjualanData = Penjualan::where('created_at', '>=', $startDate)
                    ->selectRaw("DATE_FORMAT(created_at, '$format') as date, SUM(total_harga) as total")
                    ->groupBy('date')
                    ->pluck('total', 'date');
                
                for ($i = 6; $i >= 0; $i--) {
                    $date = now()->subDays($i);
                    $label = $date->format('d M');
                    $key = $date->format('Y-m-d');
                    
                    $labels[] = $label;
                    $dataSetoran[$key] = 0;
                    $dataPenjualan[$key] = 0;
                }
                
                foreach ($setoranData as $date => $total) {
                    $dataSetoran[$date] = $total;
                }
                foreach ($penjualanData as $date => $total) {
                    $dataPenjualan[$date] = $total;
                }
            }
            
            return [
                'labels' => $labels,
                'dataSetoran' => array_values($dataSetoran),
                'dataPenjualan' => array_values($dataPenjualan)
            ];
        });

        return response()->json($chartData);
    }

    public function getBubbleChartData()
    {
        // ... (Fungsi ini tetap sama) ...
        $bubbleData = Cache::remember('dashboard_bubble_chart_data', now()->addMinutes(10), function () {
            return JenisSampah::where('stok', '>', 0)
                ->get()
                ->map(function ($sampah) {
                    $radius = (sqrt($sampah->stok) * 1.5) + 5;
                    $maxRadius = 75;

                    return [
                        'x'      => (float) $sampah->harga_per_satuan,
                        'y'      => (float) $sampah->harga_jual,
                        'r'      => min($radius, $maxRadius),
                        'label'  => $sampah->nama_sampah,
                        'stok'   => (float) $sampah->stok,
                        'satuan' => $sampah->satuan
                    ];
                });
        });

        return response()->json($bubbleData);
    }
}