<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use App\Models\KategoriTransaksi; // Tambahkan ini
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class BukuKasController extends Controller
{
    public function index(Request $request)
    {
        $query = BukuKas::with(['admin', 'kategori'])->latest('tanggal');

        // Fitur Filter Tanggal
        if ($request->filled('start_date') && $request->filled('end_date')) {
            $startDate = Carbon::parse($request->start_date)->startOfDay();
            $endDate = Carbon::parse($request->end_date)->endOfDay();
            $query->whereBetween('tanggal', [$startDate, $endDate]);
        }

        // Paginasi
        $transaksi = $query->paginate(15);

        // Kalkulasi saldo akhir tetap sama
        $pemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $pemasukan - $pengeluaran;
        
        $kategori = KategoriTransaksi::all();

        return view('pages.buku-kas.index', compact('transaksi', 'saldoAkhir', 'kategori'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'jumlah' => 'required|numeric|min:1',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id', // Validasi Kategori
        ]);

        BukuKas::create($request->all() + ['id_admin' => Auth::id()]);

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi kas berhasil dicatat!');
    }

    // Fungsi baru untuk menampilkan form edit
    public function edit(BukuKas $bukuKa)
    {
        $kategori = KategoriTransaksi::all();
        return view('pages.buku-kas.edit', compact('bukuKa', 'kategori'));
    }

    // Fungsi baru untuk memproses update
    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'jumlah' => 'required|numeric|min:1',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
        ]);

        $bukuKa->update($request->all());

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil diperbarui!');
    }


    public function destroy(BukuKas $bukuKa)
    {
        // Menggunakan soft delete
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }
}