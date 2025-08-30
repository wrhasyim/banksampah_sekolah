<?php

namespace App\Http\Controllers;

// Pastikan semua 'use' statement ini ada di bagian atas file
use App\Models\Pengguna;
use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Exports\SiswaExport;
use App\Imports\SiswaImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SiswaSampleExport;

class SiswaController extends Controller
{
    public function index()
    {
        // Menggunakan with() untuk Eager Loading agar query lebih efisien
        $siswas = Siswa::with(['pengguna', 'kelas'])->latest()->paginate(10);
        return view('pages.siswa.index', compact('siswas'));
    }

    public function create()
    {
        $kelas = Kelas::all();
        return view('pages.siswa.create', compact('kelas'));
    }

    public function store(Request $request)
{
    // 1. Validasi input dari form
    $request->validate([
        'nama_lengkap' => ['required', 'string', 'max:255'],
        'username' => ['required', 'string', 'max:255', 'unique:pengguna,username'],
        'password' => ['required', 'string', 'min:8'],
        'nis' => ['required', 'string', 'max:20', 'unique:siswa,nis'],
        'kelas_id' => ['required', 'exists:kelas,id'], // Nama input dari form adalah 'kelas_id'
    ]);

    DB::transaction(function () use ($request) {
        // Buat data pengguna
        $pengguna = Pengguna::create([
            'nama_lengkap' => $request->nama_lengkap,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'role' => 'siswa',
        ]);

        // Buat data siswa yang terhubung dengan pengguna baru
        $pengguna->siswa()->create([
            'nis' => $request->nis,
            // PERBAIKAN KUNCI: Samakan dengan nama kolom di database ('id_kelas')
            'id_kelas' => $request->kelas_id, 
        ]);
    });

    return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil ditambahkan!');
}

    public function edit(Siswa $siswa)
    {
        $kelas = Kelas::all();
        // Memuat relasi pengguna agar bisa diakses di form edit
        $siswa->load('pengguna'); 
        return view('pages.siswa.edit', compact('siswa', 'kelas'));
    }

    public function update(Request $request, Siswa $siswa)
    {
        // Validasi untuk update data
        $request->validate([
            'nama_lengkap' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:pengguna,username,' . $siswa->pengguna->id],
            'nis' => ['required', 'string', 'max:20', 'unique:siswa,nis,' . $siswa->id],
            'kelas_id' => ['required', 'exists:kelas,id'],
        ]);

        DB::transaction(function () use ($request, $siswa) {
            // Update data di tabel pengguna
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            // Update data di tabel siswa
            $siswa->update([
                'kelas_id' => $request->kelas_id,
                'nis' => $request->nis,
            ]);

            // Jika password diisi, update password
            if ($request->filled('password')) {
                $request->validate(['password' => ['required', 'string', 'min:8']]);
                $siswa->pengguna->update(['password' => Hash::make($request->password)]);
            }
        });

        return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil diperbarui!');
    }


    public function destroy(Siswa $siswa)
    {
        // Tambahkan try-catch untuk penanganan error yang lebih baik
        try {
            DB::transaction(function () use ($siswa) {
                // Hapus data siswa terlebih dahulu
                $siswa->delete();
                // Hapus juga data pengguna yang terkait
                $siswa->pengguna()->delete();
            });
            return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil dihapus.');
        } catch (\Exception $e) {
            return redirect()->route('siswa.index')->with('toastr-error', 'Gagal menghapus siswa, kemungkinan masih ada data terkait.');
        }
    }

    // ... (sisa method lainnya tidak perlu diubah) ...
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
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        Excel::import(new SiswaImport, $request->file('file'));

        return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor.');
    }

    public function getSiswaByKelas($id_kelas)
    {
        $siswa = Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get();
        return response()->json($siswa);
    }
}