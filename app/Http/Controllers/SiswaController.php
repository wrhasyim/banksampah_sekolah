<?php

namespace App\Http\Controllers;

use App\Exports\SiswaExport;
use App\Exports\SiswaSampleExport;
use App\Imports\SiswaImport;
use App\Models\Kelas;
use App\Models\Pengguna;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Facades\Excel;
use Exception;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        $perPage = $request->input('perPage', 10);
        $query = Siswa::with('kelas', 'pengguna');

        if ($request->has('search')) {
            $searchTerm = $request->search;
            $query->whereHas('pengguna', function ($q) use ($searchTerm) {
                $q->where('nama_lengkap', 'like', "%{$searchTerm}%")
                  ->orWhere('username', 'like', "%{$searchTerm}%");
            })->orWhere('nis', 'like', "%{$searchTerm}%");
        }

        $siswa = $query->paginate($perPage);

        return view('pages.siswa.index', [
            'siswa' => $siswa,
            'perPage' => $perPage,
        ]);
    }

    public function create()
    {
        return view('pages.siswa.create', [
            'kelas' => Kelas::all(),
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:pengguna,username',
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
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
                'saldo' => 0,
            ]);
        });

        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil ditambahkan!');
    }

    public function edit(Siswa $siswa)
    {
        return view('pages.siswa.edit', [
            'siswa' => $siswa->load('pengguna', 'kelas'),
            'kelas' => Kelas::all(),
        ]);
    }

    public function update(Request $request, Siswa $siswa)
    {
        $pengguna = $siswa->pengguna;

        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:pengguna,username,' . $pengguna->id,
            'password' => 'nullable|string|min:8',
            'nis' => 'nullable|string|max:20|unique:siswa,nis,' . $siswa->id,
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        DB::transaction(function () use ($request, $siswa, $pengguna) {
            $pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            if ($request->filled('password')) {
                $pengguna->update(['password' => Hash::make($request->password)]);
            }

            $siswa->update([
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
            ]);
        });
        
        return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diperbarui!');
    }


    public function destroy(Siswa $siswa)
    {
        DB::transaction(function () use ($siswa) {
            $siswa->pengguna()->delete();
            $siswa->delete();
        });

        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil dihapus!');
    }

    public function showImportForm()
    {
        return view('pages.siswa.import');
    }

    public function import(Request $request)
    {
        $request->validate(['file' => 'required|mimes:xls,xlsx']);

        try {
            Excel::import(new SiswaImport, $request->file('file'));
        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan saat mengimpor: ' . $e->getMessage());
        }

        return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor!');
    }

    public function sampleExport()
    {
        return Excel::download(new SiswaSampleExport, 'sample-siswa.xlsx');
    }

    public function export()
    {
        return Excel::download(new SiswaExport, 'siswa.xlsx');
    }
}