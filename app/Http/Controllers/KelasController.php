<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule; // Import Rule untuk validasi unik

class KelasController extends Controller
{
    public function index()
    {
        $kelas = Kelas::with('waliKelas')->latest()->get();
        return view('pages.kelas.index', compact('kelas'));
    }

    public function create()
    {
        // --- PERBAIKAN DI SINI ---
        // Ambil ID wali kelas yang sudah ditugaskan
        $assignedWaliKelasIds = Kelas::whereNotNull('id_wali_kelas')->pluck('id_wali_kelas');
        
        // Ambil hanya wali kelas yang belum ditugaskan
        $waliKelasOptions = Pengguna::where('role', 'wali')
                                    ->whereNotIn('id', $assignedWaliKelasIds)
                                    ->get();

        return view('pages.kelas.create', compact('waliKelasOptions'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_kelas' => 'required|string|max:255|unique:kelas,nama_kelas',
            // --- PERBAIKAN VALIDASI DI SINI ---
            'id_wali_kelas' => [
                'nullable',
                'exists:pengguna,id',
                Rule::unique('kelas', 'id_wali_kelas')->where(function ($query) {
                    return $query->whereNotNull('id_wali_kelas');
                })
            ],
        ]);

        Kelas::create($request->all());

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil ditambahkan.');
    }

    public function edit(Kelas $kela)
    {
        // --- PERBAIKAN DI SINI ---
        // Ambil ID wali kelas yang sudah ditugaskan, KECUALI wali kelas dari kelas yang sedang diedit
        $assignedWaliKelasIds = Kelas::whereNotNull('id_wali_kelas')
                                     ->where('id', '!=', $kela->id)
                                     ->pluck('id_wali_kelas');
        
        // Ambil wali kelas yang belum ditugaskan + wali kelas saat ini
        $waliKelasOptions = Pengguna::where('role', 'wali')
                                    ->whereNotIn('id', $assignedWaliKelasIds)
                                    ->get();

        return view('pages.kelas.edit', compact('kela', 'waliKelasOptions'));
    }

    public function update(Request $request, Kelas $kela)
    {
        $request->validate([
            'nama_kelas' => 'required|string|max:255|unique:kelas,nama_kelas,' . $kela->id,
            // --- PERBAIKAN VALIDASI DI SINI ---
            'id_wali_kelas' => [
                'nullable',
                'exists:pengguna,id',
                Rule::unique('kelas', 'id_wali_kelas')->ignore($kela->id)->where(function ($query) {
                    return $query->whereNotNull('id_wali_kelas');
                })
            ],
        ]);

        $kela->update($request->all());

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil diperbarui.');
    }

    public function destroy(Kelas $kela)
    {
        if ($kela->siswa()->count() > 0) {
            return redirect()->route('kelas.index')->with('toastr-error', 'Kelas tidak dapat dihapus karena masih memiliki siswa.');
        }

        $kela->delete();

        return redirect()->route('kelas.index')->with('toastr-success', 'Kelas berhasil dihapus.');
    }
}