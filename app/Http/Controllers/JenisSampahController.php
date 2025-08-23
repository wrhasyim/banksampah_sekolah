<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use Illuminate\Http\Request;

class JenisSampahController extends Controller
{
    public function index()
    {
        $jenisSampah = JenisSampah::all();
        return view('pages.jenis-sampah.index', [
            'jenisSampah' => $jenisSampah
        ]);
    }

    public function create()
    {
        return view('pages.jenis-sampah.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'harga_per_satuan' => 'required|numeric',
        ]);
        JenisSampah::create($request->all());
        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil ditambahkan!');
    }

    public function edit(JenisSampah $jenisSampah)
    {
        return view('pages.jenis-sampah.edit', [
            'item' => $jenisSampah
        ]);
    }

    public function update(Request $request, JenisSampah $jenisSampah)
    {
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'harga_per_satuan' => 'required|numeric',
        ]);
        $jenisSampah->update($request->all());
        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil diperbarui!');
    }

    /**
     * Hapus data dari database.
     */
    public function destroy(JenisSampah $jenisSampah)
    {
        $jenisSampah->delete();
        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil dihapus!');
    }
}