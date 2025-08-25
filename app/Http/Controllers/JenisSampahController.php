<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use Illuminate\Http\Request;

class JenisSampahController extends Controller
{
    public function index()
    {
        $jenisSampah = JenisSampah::all();
        return view('pages.jenis-sampah.index', compact('jenisSampah'));
    }

    public function create()
    {
        return view('pages.jenis-sampah.create');
    }

    public function store(Request $request)
    {
        // Tambahkan validasi untuk 'satuan'
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric',
        ]);

        // Simpan semua data dari request
        JenisSampah::create($request->all());

        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil ditambahkan!');
    }

    public function edit(JenisSampah $jenisSampah)
    {
        return view('pages.jenis-sampah.edit', ['item' => $jenisSampah]);
    }

    public function update(Request $request, JenisSampah $jenisSampah)
    {
        // Tambahkan validasi untuk 'satuan'
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric',
        ]);

        // Update semua data dari request
        $jenisSampah->update($request->all());

        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil diperbarui!');
    }

    public function destroy(JenisSampah $jenisSampah)
    {
        // Cek apakah sampah memiliki stok sebelum dihapus
        if ($jenisSampah->stok > 0) {
            return redirect()->route('jenis-sampah.index')->with('error', 'Tidak dapat menghapus jenis sampah yang masih memiliki stok.');
        }
        $jenisSampah->delete();
        return redirect()->route('jenis-sampah.index')->with('status', 'Jenis sampah berhasil dihapus!');
    }
}