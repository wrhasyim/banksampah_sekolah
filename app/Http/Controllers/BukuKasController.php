<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class BukuKasController extends Controller
{
    /**
     * Menampilkan daftar transaksi kas dengan paginasi dan filter.
     */
    public function index(Request $request)
    {
        $query = BukuKas::with(['admin', 'kategori'])->latest('tanggal');

        // Fitur Filter Berdasarkan Rentang Tanggal
        if ($request->filled('start_date') && $request->filled('end_date')) {
            $startDate = Carbon::parse($request->start_date)->startOfDay();
            $endDate = Carbon::parse($request->end_date)->endOfDay();
            $query->whereBetween('tanggal', [$startDate, $endDate]);
        }

        // Ambil data dengan Paginasi
        $transaksi = $query->paginate(15);

        // Kalkulasi total pemasukan dan pengeluaran untuk saldo akhir
        $pemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $pemasukan - $pengeluaran;
        
        // Ambil semua data kategori untuk form dropdown
        $kategori = KategoriTransaksi::all();

        // Logika untuk menghitung saldo berjalan (Running Balance)
        // Ini harus dilakukan SETELAH data paginasi diambil
        $saldoBerjalan = 0; // Anda bisa kembangkan ini lebih lanjut jika ingin saldo berjalan antar halaman
        $transaksi->getCollection()->transform(function ($trx) use (&$saldoBerjalan) {
            if ($trx->tipe == 'pemasukan') {
                $saldoBerjalan += $trx->jumlah;
            } else {
                $saldoBerjalan -= $trx->jumlah;
            }
            $trx->saldo_berjalan = $saldoBerjalan; // Menambah properti 'saldo_berjalan' ke setiap item transaksi
            return $trx;
        });

        return view('pages.buku-kas.index', compact('transaksi', 'saldoAkhir', 'kategori'));
    }

    /**
     * Menyimpan transaksi baru ke database.
     */
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

    /**
     * Menampilkan form untuk mengedit transaksi.
     */
    public function edit(BukuKas $bukuKa)
    {
        $kategori = KategoriTransaksi::all();
        // Variabel $kategori harus di-pass ke view
        return view('pages.buku-kas.edit', compact('bukuKa', 'kategori'));
    }

    /**
     * Memperbarui data transaksi di database.
     */
    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'jumlah' => 'required|numeric|min:1',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id', // Tambahkan validasi ini
        ]);

        $bukuKa->update($request->all());

        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil diperbarui!');
    }

    /**
     * Menghapus transaksi (menggunakan Soft Delete).
     */
    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }
}