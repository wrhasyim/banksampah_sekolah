<?php

namespace App\Http\Controllers;

use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;

class KategoriTransaksiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $kategori = KategoriTransaksi::latest()->paginate(10);
        return view('pages.kategori-transaksi.index', compact('kategori'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pages.kategori-transaksi.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nama_kategori' => 'required|string|max:255|unique:kategori_transaksi,nama_kategori',
            'tipe' => 'required|in:pemasukan,pengeluaran',
        ]);

        KategoriTransaksi::create($request->all());

        return redirect()->route('kategori-transaksi.index')->with('toastr-success', 'Kategori berhasil ditambahkan.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(KategoriTransaksi $kategoriTransaksi)
    {
        // Variabel yang di-pass ke view harus sama dengan yang di compact
        // Di route model binding, nama variabelnya $kategoriTransaksi
        return view('pages.kategori-transaksi.edit', ['kategori' => $kategoriTransaksi]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, KategoriTransaksi $kategoriTransaksi)
    {
        $request->validate([
            'nama_kategori' => 'required|string|max:255|unique:kategori_transaksi,nama_kategori,' . $kategoriTransaksi->id,
            'tipe' => 'required|in:pemasukan,pengeluaran',
        ]);

        $kategoriTransaksi->update($request->all());

        return redirect()->route('kategori-transaksi.index')->with('toastr-success', 'Kategori berhasil diperbarui.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(KategoriTransaksi $kategoriTransaksi)
    {
        // Cek apakah kategori masih digunakan di buku kas
        if ($kategoriTransaksi->bukuKas()->exists()) {
            return redirect()->route('kategori-transaksi.index')->with('toastr-error', 'Kategori tidak dapat dihapus karena masih digunakan dalam transaksi.');
        }

        $kategoriTransaksi->delete();

        return redirect()->route('kategori-transaksi.index')->with('toastr-success', 'Kategori berhasil dihapus.');
    }
}