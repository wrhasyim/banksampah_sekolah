<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Pengguna; // Import model Pengguna
use Illuminate\Http\Request;

class KelasController extends Controller
{
    public function index()
    {
        // Eager load relasi waliKelas untuk efisiensi query
        $kelas = Kelas::with('waliKelas')->latest()->get();
        return view('pages.kelas.index', compact('kelas'));
    }

    public function create()
    {
        // Ambil semua pengguna dengan role 'wali' untuk ditampilkan di dropdown
        $waliKelasOptions = Pengguna::where('role', 'wali')->get();
        return view('pages.kelas.create', compact('waliKelasOptions'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_kelas' => 'required|string|max:255|unique:kelas,nama_kelas',
            'id_wali_kelas' => 'nullable|exists:pengguna,id', // Validasi wali kelas
        ]);

        Kelas::create($request->all());

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil ditambahkan.');
    }

    public function edit(Kelas $kela)
    {
        // Ambil semua pengguna dengan role 'wali' untuk ditampilkan di dropdown
        $waliKelasOptions = Pengguna::where('role', 'wali')->get();
        return view('pages.kelas.edit', compact('kela', 'waliKelasOptions'));
    }

    public function update(Request $request, Kelas $kela)
    {
        $request->validate([
            'nama_kelas' => 'required|string|max:255|unique:kelas,nama_kelas,' . $kela->id,
            'id_wali_kelas' => 'nullable|exists:pengguna,id', // Validasi wali kelas
        ]);

        $kela->update($request->all());

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil diperbarui.');
    }

    public function destroy(Kelas $kela)
    {
        // Tambahkan pengecekan jika kelas masih memiliki siswa
        if ($kela->siswa()->count() > 0) {
            return redirect()->route('kelas.index')->with('toastr-error', 'Kelas tidak dapat dihapus karena masih memiliki siswa.');
        }

        $kela->delete();

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil dihapus.');
    }
}