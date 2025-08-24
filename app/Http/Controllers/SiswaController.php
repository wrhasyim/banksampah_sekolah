<?php

namespace App\Http\Controllers;

use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Pengguna;
use App\Imports\SiswaImport;
use App\Exports\SiswaExport;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use App\Exports\SiswaSampleExport;

class SiswaController extends Controller
{
    public function index()
    {
        $siswa = Siswa::with('pengguna', 'kelas')->get();
        return view('pages.siswa.index', compact('siswa'));
    }
   public function getByKelas($id_kelas)
    {
        // Cari siswa berdasarkan id_kelas dan muat relasi pengguna untuk mengambil nama
        $siswa = \App\Models\Siswa::where('id_kelas', $id_kelas)->with('pengguna')->get();

        // Kembalikan data dalam format JSON
        return response()->json($siswa);
    }
    public function exportSample()
    {
        return \Maatwebsite\Excel\Facades\Excel::download(new SiswaSampleExport, 'contoh-impor-siswa.xlsx');
    }
    public function create()
    {
        $kelas = Kelas::all();
        return view('pages.siswa.create', compact('kelas'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|unique:pengguna,username|max:255',
            'password' => 'required|string|min:8',
            'nis' => 'nullable|string|unique:siswa,nis|max:255',
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

        return redirect()->route('siswa.index')->with('status', 'Siswa berhasil ditambahkan!');
    }

    public function edit(Siswa $siswa)
    {
        $kelas = Kelas::all();
        return view('pages.siswa.edit', compact('siswa', 'kelas'));
    }
    public function show(Siswa $siswa)
    {
        return redirect()->route('siswa.index');
    }
    public function update(Request $request, Siswa $siswa)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => ['required', 'string', 'max:255', Rule::unique('pengguna')->ignore($siswa->pengguna->id)],
            'password' => 'nullable|string|min:8',
            'nis' => ['nullable', 'string', 'max:255', Rule::unique('siswa')->ignore($siswa->id)],
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        DB::transaction(function () use ($request, $siswa) {
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            if ($request->filled('password')) {
                $siswa->pengguna->update([
                    'password' => Hash::make($request->password),
                ]);
            }

            $siswa->update([
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
            ]);
        });

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil diperbarui!');
    }

    public function destroy(Siswa $siswa)
    {
        DB::transaction(function () use ($siswa) {
            $siswa->pengguna->delete();
            $siswa->delete();
        });

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil dihapus!');
    }

    // Method baru untuk mengimpor siswa
    public function showImportForm()
    {
        return view('pages.siswa.import');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        try {
            Excel::import(new SiswaImport, $request->file('file'));
        } catch (ValidationException $e) {
            $failures = $e->failures();
            return back()->with('import_errors', $failures)->withInput();
        }

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil diimpor!');
    }

    
}