<?php

namespace App\Http\Controllers;

use App\Models\Pengguna;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Insentif; // Tetap ada, meskipun tidak terpakai di controller ini
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Exports\SiswaExport;
use App\Imports\SiswaImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SiswaSampleExport;

// --- TAMBAHAN BARU UNTUK FITUR FILTER & EXPORT ---
use App\Exports\SiswaTidakAktifExport; // Class Export baru yang akan kita buat
use Barryvdh\DomPDF\Facade\Pdf;       // Untuk Export PDF
use Carbon\Carbon;                   // Untuk filter rentang waktu
// --- AKHIR TAMBAHAN BARU ---

class SiswaController extends Controller
{
    /**
     * ========================================================================
     * FUNGSI INDEX (DIMODIFIKASI)
     * ========================================================================
     */
    public function index(Request $request)
    {
        $kelas = Kelas::orderBy('nama_kelas')->get();
        
        // Panggil query builder yang baru
        $query = $this->buildSiswaQuery($request);

        // Tambahkan relasi 'pengguna', 'kelas' (dari query asli)
        // dan 'setoranTerakhir' (untuk fitur baru)
        $query->with(['pengguna', 'kelas', 'setoranTerakhir' => function ($query) {
            $query->latest('created_at');
        }]);

        $siswas = $query->orderBy('pengguna.nama_lengkap', 'asc')->paginate(10)->withQueryString();

        return view('pages.siswa.index', compact('siswas', 'kelas'));
    }

    /**
     * ========================================================================
     * FUNGSI HELPER BARU UNTUK MEMBANGUN QUERY SISWA
     * ========================================================================
     */
    private function buildSiswaQuery(Request $request)
    {
        // === PERBAIKAN BUG EXPORT: ->with('pengguna') DIHAPUS DARI SINI ===
        // Panggilan 'with()' akan dilakukan di 'index' dan 'export'
        $query = Siswa::query()
                    ->join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
                    ->select('siswa.*');
        
        // --- Menggabungkan filter 'id_kelas' yang sudah ada ---
        if ($request->filled('id_kelas')) {
            $query->where('id_kelas', $request->id_kelas);
        }

        // --- Menambahkan filter 'tidak_aktif' yang baru ---
        $filterTidakAktif = $request->input('filter_tidak_aktif');
        if ($filterTidakAktif) {
            $cutoffDate = null;

            // Logika "Lebih dari" (> 1 Minggu), kita gunakan startOfDay() untuk konsistensi
            if ($filterTidakAktif == '1w') {
                // "Tidak setor > 1 minggu" = setoran terakhir < 7 hari yang lalu
                $cutoffDate = Carbon::now()->subWeek()->startOfDay();
            } elseif ($filterTidakAktif == '1m') {
                $cutoffDate = Carbon::now()->subMonth()->startOfDay();
            } elseif ($filterTidakAktif == '2m') {
                $cutoffDate = Carbon::now()->subMonths(2)->startOfDay();
            }

            if ($cutoffDate) {
                // Logika utama:
                // Cari siswa yang TIDAK PUNYA (whereDoesntHave) setoran
                // yang tanggal dibuatnya LEBIH BARU (>=) dari tanggal cutoff.
                $query->whereDoesntHave('setoran', function ($subQuery) use ($cutoffDate) {
                    $subQuery->where('created_at', '>=', $cutoffDate);
                });
            }
        }
        
        return $query;
    }

    /**
     * ========================================================================
     * FUNGSI HELPER BARU UNTUK TEKS LAPORAN PDF
     * ========================================================================
     */
    private function getFilterText($filterTidakAktif)
    {
        switch ($filterTidakAktif) {
            case '1w':
                return 'Tidak setor dalam 1 minggu terakhir';
            case '1m':
                return 'Tidak setor dalam 1 bulan terakhir';
            case '2m':
                return 'Tidak setor dalam 2 bulan terakhir';
            default:
                return 'Semua Siswa (Termasuk yang Aktif)';
        }
    }

    
    /**
     * ========================================================================
     * FUNGSI CRUD (TIDAK DIUBAH)
     * create, store, edit, update
     * ========================================================================
     */

    public function create()
    {
        $kelas = Kelas::all();
        return view('pages.siswa.create', compact('kelas'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:pengguna,username'],
            'password' => ['required', 'string', 'min:8'],
            'nis' => ['required', 'string', 'max:20', 'unique:siswa,nis'],
            'id_kelas' => ['required', 'exists:kelas,id'],
        ]);

        DB::transaction(function () use ($request) {
            $pengguna = Pengguna::create([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
                'password' => Hash::make($request->password),
                'role' => 'siswa',
            ]);

            $pengguna->siswa()->create([
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
            ]);
        });

        return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil ditambahkan!');
    }

    public function edit(Siswa $siswa)
    {
        $kelas = Kelas::all();
        $siswa->load('pengguna'); 
        return view('pages.siswa.edit', compact('siswa', 'kelas'));
    }

    public function update(Request $request, Siswa $siswa)
    {
        $request->validate([
            'nama_lengkap' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:pengguna,username,' . $siswa->pengguna->id],
            'nis' => ['required', 'string', 'max:20', 'unique:siswa,nis,' . $siswa->id],
            'id_kelas' => ['required', 'exists:kelas,id'],
            'password' => ['nullable', 'string', 'min:8'],
        ]);

        DB::transaction(function () use ($request, $siswa) {
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            $siswa->update([
                'id_kelas' => $request->id_kelas,
                'nis' => $request->nis,
            ]);

            if ($request->filled('password')) {
                $siswa->pengguna->update(['password' => Hash::make($request->password)]);
            }
        });

        return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil diperbarui!');
    }

    /**
     * FUNGSI DESTROY (TIDAK DIUBAH)
     */
    public function destroy(Siswa $siswa)
    {
        try {
            DB::transaction(function () use ($siswa) {
                // Simpan data pengguna sebelum siswa dihapus
                $pengguna = $siswa->pengguna;

                // 1. Hapus semua setoran dan kurangi stok sampah
                foreach ($siswa->setoran as $setoran) {
                    if ($setoran->jenisSampah) {
                        $setoran->jenisSampah->decrement('stok', $setoran->jumlah);
                    }
                    $setoran->delete();
                }

                // 2. Hapus semua penarikan siswa
                $siswa->penarikan()->delete();

                // 3. Hapus data siswa itu sendiri
                $siswa->delete();

                // 4. Hapus data pengguna yang terkait
                if ($pengguna) {
                    $pengguna->delete();
                }
            });

            return redirect()->route('siswa.index')->with('toastr-success', 'Siswa dan semua data terkait berhasil dihapus.');
        } catch (\Exception $e) {
            // Untuk debugging, Anda bisa melihat error di file log Laravel
            \Log::error('Gagal menghapus siswa: ' . $e->getMessage());
            return redirect()->route('siswa.index')->with('toastr-error', 'Gagal menghapus siswa karena masih ada data yang terkait.');
        }
    }

    /**
     * ========================================================================
     * FUNGSI SELECT2 AJAX (TIDAK DIUBAH)
     * ========================================================================
     */
    public function selectSiswa(Request $request)
    {
        $search = $request->input('search', '');
        $data = [];

        if (strlen($search) >= 2) { // Cari setelah pengguna mengetik min. 2 karakter
            $siswas = Siswa::with('pengguna')
                ->whereHas('pengguna', function ($query) use ($search) {
                    $query->where('nama_lengkap', 'like', "%{$search}%");
                })
                ->limit(20) // Batasi hasil untuk performa
                ->get();

            foreach ($siswas as $siswa) {
                $data[] = [
                    'id' => $siswa->id,
                    'text' => $siswa->pengguna->nama_lengkap . ' (Saldo: Rp ' . number_format($siswa->saldo, 0, ',', '.') . ')'
                ];
            }
        }

        return response()->json($data);
    }

    /**
     * ========================================================================
     * FUNGSI BARU UNTUK EXPORT (XLSX & PDF)
     * ========================================================================
     */
    public function exportXlsx(Request $request)
    {
        // Panggil query builder yang sama
        $query = $this->buildSiswaQuery($request);
        
        // Panggil 'with()' di sini. Ini akan memuat SEMUA relasi yang dibutuhkan.
        $siswa = $query->with(['pengguna', 'kelas', 'setoranTerakhir' => function ($query) {
            $query->latest('created_at');
        }])
        ->orderBy('pengguna.nama_lengkap', 'asc')->get();

        // Ganti nama 'nama_lengkap' di relasi pengguna menjadi 'nama'
        $siswa->each(function($item) {
            // Cek null safety jika pengguna terhapus
            if ($item->pengguna) {
                $item->nama = $item->pengguna->nama_lengkap;
            } else {
                $item->nama = '[Pengguna Hilang]';
            }
        });

        return Excel::download(new SiswaTidakAktifExport($siswa), 'laporan_siswa_tidak_aktif.xlsx');
    }

    public function exportPdf(Request $request)
    {
        $filterTidakAktif = $request->input('filter_tidak_aktif');

        // Panggil query builder yang sama
        $query = $this->buildSiswaQuery($request);
        
        // Panggil 'with()' di sini. Ini akan memuat SEMUA relasi yang dibutuhkan.
        $siswa = $query->with(['pengguna', 'kelas', 'setoranTerakhir' => function ($query) {
            $query->latest('created_at');
        }])
        ->orderBy('pengguna.nama_lengkap', 'asc')->get();

        // Ganti nama 'nama_lengkap' di relasi pengguna menjadi 'nama'
        $siswa->each(function($item) {
            // Cek null safety jika pengguna terhapus
            if ($item->pengguna) {
                $item->nama = $item->pengguna->nama_lengkap;
            } else {
                $item->nama = '[Pengguna Hilang]';
            }
        });

        $filterText = $this->getFilterText($filterTidakAktif);

        $pdf = Pdf::loadView('pages.siswa.export-pdf', compact('siswa', 'filterText'));
        return $pdf->download('laporan_siswa_tidak_aktif.pdf');
    }

    /**
     * ========================================================================
     * FUNGSI IMPORT/EXPORT LAINNYA (TIDAK DIUBAH)
     * ========================================================================
     */
    public function export() 
    { 
        return Excel::download(new SiswaExport, 'siswa.xlsx'); 
    }
    
    public function sampleExport() 
    { 
        return Excel::download(new SiswaSampleExport, 'sample-siswa.xlsx'); 
    }
    
    public function showImportForm() 
    { 
        return view('pages.siswa.import'); 
    }
    
    public function import(Request $request) 
    { 
        $request->validate(['file' => 'required|mimes:xlsx,xls']); 
        Excel::import(new SiswaImport, $request->file('file')); 
        return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor.'); 
    }
    
    public function getSiswaByKelas($id_kelas) 
    { 
        $siswa = Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get(); 
        return response()->json($siswa); 
    }
}