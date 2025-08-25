<?php

namespace App\Http\Controllers;

use App\Models\KasKecil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class KasKecilController extends Controller
{
    public function index()
    {
        $transaksi = KasKecil::with('admin')->latest('tanggal')->get();

        // Hitung saldo akhir
        $pemasukan = KasKecil::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = KasKecil::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $pemasukan - $pengeluaran;

        return view('pages.kas-kecil.index', compact('transaksi', 'saldoAkhir'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'tipe' => 'required|in:pemasukan,pengeluaran',
            'jumlah' => 'required|numeric|min:1',
        ]);

        KasKecil::create($request->all() + ['id_admin' => Auth::id()]);

        return redirect()->route('kas-kecil.index')->with('toastr-success', 'Transaksi kas kecil berhasil dicatat!');
    }

    public function destroy(KasKecil $kasKecil)
    {
        $kasKecil->delete();
        return redirect()->route('kas-kecil.index')->with('toastr-success', 'Transaksi berhasil dihapus.');
    }
}