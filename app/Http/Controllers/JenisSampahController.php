<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use Illuminate\Http\Request;

class JenisSampahController extends Controller
{
    /**
     * Menampilkan daftar jenis sampah.
     */
    public function index()
    {
        $jenisSampah = JenisSampah::where('status', 'aktif')->latest()->paginate(10);
        return view('pages.jenis-sampah.index', compact('jenisSampah'));
    }

    /**
     * Menampilkan form untuk membuat jenis sampah baru.
     */
    public function create()
    {
        return view('pages.jenis-sampah.create');
    }

    /**
     * Menyimpan jenis sampah baru ke database.
     */
    public function store(Request $request)
    {
        // MODIFIKASI: Menambahkan 'harga_jual' pada validasi
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0', // Ditambahkan
        ]);

        // MODIFIKASI: Menambahkan 'harga_jual' pada data yang disimpan
        JenisSampah::create([
            'nama_sampah' => $request->nama_sampah,
            'satuan' => $request->satuan,
            'harga_per_satuan' => $request->harga_per_satuan,
            'harga_jual' => $request->harga_jual, // Ditambahkan
        ]);
        
        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil ditambahkan!');
    }

    /**
     * Menampilkan form untuk mengedit jenis sampah.
     */
    public function edit(JenisSampah $jenisSampah)
    {
        return view('pages.jenis-sampah.edit', ['item' => $jenisSampah]);
    }

    /**
     * Memperbarui data jenis sampah di database.
     */
    public function update(Request $request, JenisSampah $jenisSampah)
    {
        // MODIFIKASI: Menambahkan 'harga_jual' pada validasi
        $request->validate([
            'nama_sampah' => 'required|string|max:50',
            'satuan' => 'required|in:pcs,kg',
            'harga_per_satuan' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0', // Ditambahkan
        ]);

        // MODIFIKASI: Memperbarui data termasuk 'harga_jual'
        $jenisSampah->update([
            'nama_sampah' => $request->nama_sampah,
            'satuan' => $request->satuan,
            'harga_per_satuan' => $request->harga_per_satuan,
            'harga_jual' => $request->harga_jual, // Ditambahkan
        ]);

        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil diperbarui!');
    }

    /**
     * Menghapus (menonaktifkan) jenis sampah.
     */
    public function destroy(JenisSampah $jenisSampah)
    {
        // Cek jika stok masih ada
        if ($jenisSampah->stok > 0) {
            return redirect()->route('jenis-sampah.index')->with('toastr-error', 'Tidak dapat menghapus jenis sampah yang masih memiliki stok.');
        }

        // Jika stok 0, ubah status menjadi 'tidak aktif'
        $jenisSampah->update(['status' => 'tidak aktif']);

        return redirect()->route('jenis-sampah.index')->with('toastr-success', 'Jenis sampah berhasil dihapus!');
    }
}