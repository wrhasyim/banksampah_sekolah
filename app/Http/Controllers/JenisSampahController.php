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
        // Menggunakan nama kolom yang benar 'nama_sampah' untuk sorting jika diperlukan
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
        // PERBAIKAN: Menggunakan nama kolom 'nama_sampah' dan 'harga_per_satuan'
        $request->validate([
            'nama_sampah' => 'required|string|max:255',
            'kategori' => 'required|string|in:Siswa,Pengelola',
            'harga_per_satuan' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
            'satuan' => 'required|string',
            // 'deskripsi' tidak ada di tabel Anda, jadi saya hapus dari validasi
        ]);

        JenisSampah::create([
            'nama_sampah' => $request->nama_sampah,
            'kategori' => $request->kategori,
            'harga_per_satuan' => $request->harga_per_satuan,
            'harga_jual' => $request->harga_jual,
            'satuan' => $request->satuan,
        ]);
        
        return redirect()->route('jenis-sampah.index')->with('success', 'Jenis sampah berhasil ditambahkan!');
    }

    /**
     * Menampilkan form untuk mengedit jenis sampah.
     */
    public function edit(JenisSampah $jenisSampah)
    {
        // PERBAIKAN: Mengirim variabel dengan nama 'jenisSampah' ke view
        return view('pages.jenis-sampah.edit', compact('jenisSampah'));
    }

    /**
     * Memperbarui data jenis sampah di database.
     */
    public function update(Request $request, JenisSampah $jenisSampah)
    {
        // PERBAIKAN: Menggunakan nama kolom 'nama_sampah' dan 'harga_per_satuan'
        $request->validate([
            'nama_sampah' => 'required|string|max:255',
            'kategori' => 'required|string|in:Siswa,Pengelola',
            'harga_per_satuan' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
            'satuan' => 'required|string',
        ]);

        $jenisSampah->update([
            'nama_sampah' => $request->nama_sampah,
            'kategori' => $request->kategori,
            'harga_per_satuan' => $request->harga_per_satuan,
            'harga_jual' => $request->harga_jual,
            'satuan' => $request->satuan,
        ]);

        return redirect()->route('jenis-sampah.index')->with('success', 'Jenis sampah berhasil diperbarui!');
    }

    /**
     * Menghapus (menonaktifkan) jenis sampah.
     */
    public function destroy(JenisSampah $jenisSampah)
    {
        // Cek jika stok masih ada
        if ($jenisSampah->stok > 0) {
            return redirect()->route('jenis-sampah.index')->with('error', 'Tidak dapat menghapus jenis sampah yang masih memiliki stok.');
        }

        // Jika stok 0, ubah status menjadi 'tidak aktif'
        $jenisSampah->update(['status' => 'tidak aktif']);

        return redirect()->route('jenis-sampah.index')->with('success', 'Jenis sampah berhasil dihapus!');
    }
}