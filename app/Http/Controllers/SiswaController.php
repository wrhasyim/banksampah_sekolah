<?php

namespace App\Http\Controllers;

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
        // PERBAIKAN: Validasi yang sesuai dengan form edit
        $request->validate([
            'nama_lengkap' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:pengguna,username,' . $siswa->pengguna->id],
            'nis' => ['required', 'string', 'max:20', 'unique:siswa,nis,' . $siswa->id],
            'id_kelas' => ['required', 'exists:kelas,id'],
            'password' => ['nullable', 'string', 'min:8'], // Password tidak wajib diisi saat update
        ]);

        DB::transaction(function () use ($request, $siswa) {
            // Update data di tabel pengguna
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            // Update data di tabel siswa
            $siswa->update([
                'id_kelas' => $request->id_kelas,
                'nis' => $request->nis,
            ]);

            // Jika password diisi, maka update passwordnya
            if ($request->filled('password')) {
                $siswa->pengguna->update(['password' => Hash::make($request->password)]);
            }
        });

        return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil diperbarui!');
    }

    public function destroy(Siswa $siswa)
    {
        try {
            DB::transaction(function () use ($siswa) {
                $siswa->pengguna()->delete(); // Hapus pengguna dulu
                $siswa->delete(); // Baru hapus siswanya
            });
            return redirect()->route('siswa.index')->with('toastr-success', 'Siswa berhasil dihapus.');
        } catch (\Exception $e) {
            return redirect()->route('siswa.index')->with('toastr-error', 'Gagal menghapus siswa, kemungkinan masih ada data terkait.');
        }
    }

    // ... sisa method tidak berubah ...
    public function export() { return Excel::download(new SiswaExport, 'siswa.xlsx'); }
    public function sampleExport() { return Excel::download(new SiswaSampleExport, 'sample-siswa.xlsx'); }
    public function showImportForm() { return view('pages.siswa.import'); }
    public function import(Request $request) { $request->validate(['file' => 'required|mimes:xlsx,xls']); Excel::import(new SiswaImport, $request->file('file')); return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor.'); }
    public function getSiswaByKelas($id_kelas) { $siswa = Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get(); return response()->json($siswa); }
}