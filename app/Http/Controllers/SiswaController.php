<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Pengguna;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use App\Imports\SiswaImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SiswaExport;
use App\Exports\SiswaSampleExport;

class SiswaController extends Controller
{
    /**
     * Menampilkan daftar siswa dengan paginasi.
     */
    public function index(Request $request)
    {
        // Ambil nilai 'per_page' dari URL, default-nya 10 jika tidak ada
        $perPage = $request->query('per_page', 10);

        // Ambil data siswa dengan paginasi
        $siswa = Siswa::with(['pengguna', 'kelas'])->paginate($perPage);

        // Kirim data siswa dan nilai perPage ke view
        return view('pages.siswa.index', compact('siswa', 'perPage'));
    }

    /**
     * Mengambil data siswa berdasarkan ID Kelas untuk AJAX request.
     */
    public function getByKelas($id_kelas)
    {
        $siswa = Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get();
        return response()->json($siswa);
    }

    public function create()
    {
        $kelas = Kelas::all();
        return view('pages.siswa.create', compact('kelas'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:100',
            'username' => 'required|string|max:50|unique:pengguna,username',
            'password' => 'required|string|min:8',
            'nis' => 'nullable|string|max:20|unique:siswa,nis',
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        DB::transaction(function () use ($request) {
            $pengguna = Pengguna::create([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
                'password' => Hash::make($request->password),
                'role' => 'siswa',
            ]);

            Siswa::create([
                'id_pengguna' => $pengguna->id,
                'id_kelas' => $request->id_kelas,
                'nis' => $request->nis,
                'saldo' => 0,
            ]);
        });

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil ditambahkan!');
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
            'nama_lengkap' => 'required|string|max:100',
            'username' => ['required', 'string', 'max:50', Rule::unique('pengguna')->ignore($siswa->id_pengguna)],
            'nis' => ['nullable', 'string', 'max:20', Rule::unique('siswa')->ignore($siswa->id)],
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        DB::transaction(function () use ($request, $siswa) {
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            $siswa->update([
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
            ]);

            if ($request->filled('password')) {
                $request->validate(['password' => 'string|min:8']);
                $siswa->pengguna->update(['password' => Hash::make($request->password)]);
            }
        });

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil diperbarui!');
    }

    public function destroy(Siswa $siswa)
    {
        $siswa->pengguna->delete();
        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil dihapus!');
    }
    
    public function showImportForm()
    {
        return view('pages.siswa.import');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls'
        ]);

        (new SiswaImport)->queue($request->file('file'));

        return redirect()->route('siswa.import.form')->with('success', 'File Anda sedang diproses. Data akan muncul secara bertahap.');
    }
    
    public function exportSample()
    {
        return Excel::download(new SiswaSampleExport, 'contoh-impor-siswa.xlsx');
    }

    /**
     * Mengekspor data siswa ke Excel.
     */
    public function export()
    {
        return Excel::download(new SiswaExport, 'data-siswa.xlsx');
    }
}