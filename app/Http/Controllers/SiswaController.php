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

class SiswaController extends Controller
{
    public function index()
    {
        // Ambil data siswa beserta relasi ke pengguna dan kelas
        $siswa = Siswa::with(['pengguna', 'kelas'])->get();
        return view('pages.siswa.index', compact('siswa'));
    }

    public function create()
    {
        // Ambil semua data kelas untuk ditampilkan di dropdown
        $kelas = Kelas::all();
        return view('pages.siswa.create', compact('kelas'));
    }
public function exportSample()
    {
        return Excel::download(new SiswaExport, 'siswa-template.xlsx');
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

        return redirect()->route('siswa.index')->with('success', 'Data siswa berhasil diimpor!');
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

        // Gunakan transaksi database untuk memastikan kedua data berhasil dibuat
        DB::transaction(function () use ($request) {
            // 1. Buat data di tabel pengguna
            $pengguna = Pengguna::create([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
                'password' => Hash::make($request->password),
                'role' => 'siswa',
            ]);

            // 2. Buat data di tabel siswa
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
        // Ambil semua data kelas untuk dropdown
        $kelas = Kelas::all();
        // Muat relasi pengguna agar bisa diakses di view
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
            // Update data pengguna
            $siswa->pengguna->update([
                'nama_lengkap' => $request->nama_lengkap,
                'username' => $request->username,
            ]);

            // Update data siswa
            $siswa->update([
                'nis' => $request->nis,
                'id_kelas' => $request->id_kelas,
            ]);

            // Jika password diisi, update password
            if ($request->filled('password')) {
                $request->validate(['password' => 'string|min:8']);
                $siswa->pengguna->update(['password' => Hash::make($request->password)]);
            }
        });

        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil diperbarui!');
    }

    public function destroy(Siswa $siswa)
    {
        // Hapus data pengguna yang berelasi, maka data siswa akan ikut terhapus (karena onDelete cascade)
        $siswa->pengguna->delete();
        return redirect()->route('siswa.index')->with('status', 'Data siswa berhasil dihapus!');
    }
}