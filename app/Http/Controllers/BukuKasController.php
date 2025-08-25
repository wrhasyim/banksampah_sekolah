<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BukuKasController extends Controller
{
    public function index()
    {
        $transaksi = BukuKas::with('admin')->latest('tanggal')->get();
        $pemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $pemasukan - $pengeluaran;

        return view('pages.buku-kas.index', compact('transaksi', 'saldoAkhir'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'jumlah' => 'required|numeric|min:1',
        ]);
        BukuKas::create($request->all() + ['id_admin' => Auth::id()]);
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi kas berhasil dicatat!');
    }

    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }
}