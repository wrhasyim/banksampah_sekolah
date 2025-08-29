<?php

namespace App\Http\Controllers;

use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Http\Request;
use App\Exports\SiswaExport;
use App\Imports\SiswaImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SiswaSampleExport;
use Illuminate\Support\Facades\Log;

class SiswaController extends Controller
{
    // PERBAIKAN: Menambahkan paginasi
    public function index()
    {
        $siswas = Siswa::with('kelas')->paginate(10); // Mengambil 10 siswa per halaman
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
            'nama' => 'required',
            'id_kelas' => 'required',
            'nis' => 'nullable|unique:siswa,nis',
            'alamat' => 'nullable',
            'telepon' => 'nullable',
        ]);

        Siswa::create($request->all());
        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil ditambahkan.');
    }

    public function edit(Siswa $siswa)
    {
        $kelas = Kelas::all();
        return view('pages.siswa.edit', compact('siswa', 'kelas'));
    }

    public function update(Request $request, Siswa $siswa)
    {
        $request->validate([
            'nama' => 'required',
            'id_kelas' => 'required',
            'nis' => 'nullable|unique:siswa,nis,' . $siswa->id,
            'alamat' => 'nullable',
            'telepon' => 'nullable',
        ]);

        $siswa->update($request->all());
        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil diperbarui.');
    }

    public function destroy(Siswa $siswa)
    {
        $siswa->delete();
        return redirect()->route('siswa.index')->with('success', 'Siswa berhasil dihapus.');
    }

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