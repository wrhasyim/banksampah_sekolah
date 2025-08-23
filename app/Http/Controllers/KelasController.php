<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use Illuminate\Http\Request;

class KelasController extends Controller
{
    public function index()
    {
        $kelas = Kelas::all();
    // Variabel yang dikirim ke view adalah 'kelas'
    return view('pages.kelas.index', compact('kelas'));
    }

    public function create()
    {
        return view('pages.kelas.create');
    }

    public function store(Request $request)
    {
        $request->validate(['nama_kelas' => 'required|string|max:50']);
        Kelas::create($request->all());
        return redirect()->route('kelas.index')->with('status', 'Data kelas berhasil ditambahkan!');
    }

    public function show(Kelas $kela)
    {
        // Tidak kita gunakan untuk sekarang
    }

    public function edit(Kelas $kela)
    {
        return view('pages.kelas.edit', ['item' => $kela]);
    }

    public function update(Request $request, Kelas $kela)
    {
        $request->validate(['nama_kelas' => 'required|string|max:50']);
        $kela->update($request->all());
        return redirect()->route('kelas.index')->with('status', 'Data kelas berhasil diperbarui!');
    }

    public function destroy(Kelas $kela)
    {
        $kela->delete();
        return redirect()->route('kelas.index')->with('status', 'Data kelas berhasil dihapus!');
    }
}