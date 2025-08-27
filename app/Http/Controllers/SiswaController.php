<?php

namespace App\Http\Controllers;

use App\Exports\SiswaExport;
use App\Exports\SiswaSampleExport;
use App\Imports\SiswaImport;
use App\Models\Kelas;
use App\Models\Pengguna;
use App\Models\Siswa;
use Illuminate\Http\Request; // <-- Tambahkan ini
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Facades\Excel;

class SiswaController extends Controller
{
    public function showImportForm()
    {
        return view('pages.siswa.import');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xls,xlsx'
        ]);

        Excel::import(new SiswaImport, $request->file('file'));

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
    
    /**
     * PERBAIKAN: Menggunakan paginasi.
     */
    public function index(Request $request)
    {
        $perPage = $request->input('perPage', 10);
        $siswa = Siswa::with('kelas', 'pengguna')->paginate($perPage);

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
            'nama' => 'required',
            'email' => 'required|email|unique:pengguna,email',
            'password' => 'required|min:8',
            'nis' => 'required|unique:siswa,nis',
            'id_kelas' => 'required',
            'alamat' => 'required',
            'telepon' => 'required',
        ]);

        $pengguna = Pengguna::create([
            'name' => $request->nama,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'siswa',
        ]);

        Siswa::create([
            'nis' => $request->nis,
            'id_kelas' => $request->id_kelas,
            'alamat' => $request->alamat,
            'telepon' => $request->telepon,
            'id_pengguna' => $pengguna->id,
        ]);

        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil ditambahkan');
    }

    public function edit(Siswa $siswa)
    {
        return view('pages.siswa.edit', [
            'siswa' => $siswa,
            'kelas' => Kelas::all(),
        ]);
    }

    public function update(Request $request, Siswa $siswa)
    {
        $request->validate([
            'nama' => 'required',
            'email' => 'required|email|unique:pengguna,email,' . $siswa->pengguna->id,
            'nis' => 'required|unique:siswa,nis,' . $siswa->id,
            'id_kelas' => 'required',
            'alamat' => 'required',
            'telepon' => 'required',
        ]);

        $siswa->pengguna->update([
            'name' => $request->nama,
            'email' => $request->email,
        ]);

        if ($request->password) {
            $siswa->pengguna->update([
                'password' => Hash::make($request->password),
            ]);
        }

        $siswa->update([
            'nis' => $request->nis,
            'id_kelas' => $request->id_kelas,
            'alamat' => $request->alamat,
            'telepon' => $request->telepon,
        ]);

        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil diupdate');
    }

    public function destroy(Siswa $siswa)
    {
        $siswa->pengguna->delete();
        $siswa->delete();

        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil dihapus');
    }
}