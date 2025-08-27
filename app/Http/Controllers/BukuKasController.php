<?php

namespace App\Http\Controllers;

use App\Exports\BukuKasExport;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;

class BukuKasController extends Controller
{
    /**
     * PERBAIKAN: Method baru untuk mengekspor ke Excel.
     */
    public function exportExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        return Excel::download(new BukuKasExport($bulan, $tahun), 'buku-kas.xlsx');
    }

    public function exportPdf(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        $bukuKas = BukuKas::whereMonth('tanggal', $bulan)
            ->whereYear('tanggal', $tahun)
            ->orderBy('tanggal', 'asc')
            ->get();

        $saldoAwal = BukuKas::where('tanggal', '<', date($tahun . '-' . $bulan . '-01'))
            ->sum(DB::raw('CASE WHEN tipe = "pemasukan" THEN jumlah ELSE -jumlah END'));

        $pdf = Pdf::loadView('pages.buku-kas.buku-kas-pdf', compact('bukuKas', 'saldoAwal', 'bulan', 'tahun'));
        return $pdf->download('buku-kas.pdf');
    }
    
    public function index(Request $request)
    {
        $bulan = $request->input('bulan', date('m'));
        $tahun = $request->input('tahun', date('Y'));

        $bukuKas = BukuKas::whereMonth('tanggal', $bulan)
            ->whereYear('tanggal', $tahun)
            ->orderBy('tanggal', 'asc')
            ->get();

        $totalPemasukan = BukuKas::where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;

        $kategori = KategoriTransaksi::all();

        return view('pages.buku-kas.index', compact('bukuKas', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'kategori', 'bulan', 'tahun'));
    }

    public function create()
    {
        //
    }

    public function store(Request $request)
    {
        $request->validate([
            'keterangan' => 'required',
            'jumlah' => 'required|numeric',
            'tipe' => 'required',
            'tanggal' => 'required|date',
            'kategori_transaksi_id' => 'required',
        ]);

        BukuKas::create($request->all());

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil ditambahkan.');
    }

    public function show(BukuKas $bukuKas)
    {
        //
    }

    public function edit(BukuKas $bukuKas)
    {
        return view('pages.buku-kas.edit', compact('bukuKas'));
    }

    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'keterangan' => 'required',
            'jumlah' => 'required|numeric',
            'tipe' => 'required',
            'tanggal' => 'required|date',
        ]);

        $bukuKa->update($request->all());

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil diubah.');
    }

    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil dihapus.');
    }
}