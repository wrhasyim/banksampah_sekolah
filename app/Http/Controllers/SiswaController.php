<?php

namespace App\Http\Controllers;

use App\Models\Pengguna;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Insentif;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Exports\SiswaExport;
use App\Imports\SiswaImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SiswaSampleExport;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        $kelas = Kelas::orderBy('nama_kelas')->get();
        
        $query = Siswa::with(['pengguna', 'kelas']);

        if ($request->filled('id_kelas')) {
            $query->where('id_kelas', $request->id_kelas);
        }

        $siswas = $query->latest()->paginate(10);

        return view('pages.siswa.index', compact('siswas', 'kelas'));
    }


    
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
     * PERBAIKAN: Fungsi destroy diubah untuk memastikan semua data terkait terhapus dengan benar.
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
     * FUNGSI BARU UNTUK PENCARIAN SISWA (SELECT2 AJAX)
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


    // ... sisa method tidak berubah ...
    public function export() { return Excel::download(new SiswaExport, 'siswa.xlsx'); }
    public function sampleExport() { return Excel::download(new SiswaSampleExport, 'sample-siswa.xlsx'); }
    public function showImportForm() { return view('pages.siswa.import'); }
    public function import(Request $request) { $request->validate(['file' => 'required|mimes:xlsx,xls']); Excel::import(new SiswaImport, $request->file('file')); return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor.'); }
    public function getSiswaByKelas($id_kelas) { $siswa = Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get(); return response()->json($siswa); }
}