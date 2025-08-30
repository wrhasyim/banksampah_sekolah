<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use Illuminate\Http\Request;

class JenisSampahController extends Controller
{
    public function index()
    {
        $jenisSampah = JenisSampah::where('status', 'aktif')->latest()->paginate(10);
        return view('pages.jenis-sampah.index', compact('jenisSampah'));
    }

    public function create()
    {
        return view('pages.jenis-sampah.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric',
        ]);

        JenisSampah::create($request->only(['nama_sampah', 'satuan', 'harga_per_satuan']));
        
        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil ditambahkan!');
    }

    public function edit(JenisSampah $jenisSampah)
    {
        return view('pages.jenis-sampah.edit', ['item' => $jenisSampah]);
    }

    public function update(Request $request, JenisSampah $jenisSampah)
    {
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric',
        ]);
        $jenisSampah->update($request->all());
        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil diperbarui!');
    }

    public function destroy(JenisSampah $jenisSampah)
    {
        // HANYA CEK STOK: Jika stok > 0, kirim pesan error.
        if ($jenisSampah->stok > 0) {
            return redirect()->route('jenis-sampah.index')->with('toastr-error', 'Tidak dapat menghapus jenis sampah yang masih memiliki stok.');
        }

        // Jika stok 0, ubah status dan kirim pesan sukses.
        $jenisSampah->update(['status' => 'tidak aktif']);

        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil dihapus!');
    }
}