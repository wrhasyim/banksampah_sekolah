<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use Illuminate\Http\Request;
use App\Exports\BukuKasExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;
use App\Models\KategoriTransaksi;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class BukuKasController extends Controller
{
    public function index(Request $request)
    {
        $selectedMonth = $request->input('bulan', date('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $bukuKas = BukuKas::with('kategori') 
            ->whereBetween('tanggal', [$startDate, $endDate])
            ->latest('tanggal')
            ->paginate(10);

        $totalPemasukan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pengeluaran')->sum('jumlah');
        
        $saldoAkhir = BukuKas::where('tipe', 'pemasukan')->sum('jumlah') - BukuKas::where('tipe', 'pengeluaran')->sum('jumlah');
        
        $kategoriTransaksi = KategoriTransaksi::orderBy('nama_kategori')->get();

        return view('pages.buku-kas.index', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'kategoriTransaksi'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'jumlah' => 'required|numeric|min:0',
            'id_kategori' => 'nullable|exists:kategori_transaksis,id',
            'tipe' => 'required_if:id_kategori,null|in:pemasukan,pengeluaran',
        ]);
        
        $tipe = $request->tipe;
        if ($request->filled('id_kategori')) {
            $kategori = KategoriTransaksi::find($request->id_kategori);
            $tipe = $kategori->tipe;
        }

        BukuKas::create([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi,
            'jumlah' => $request->jumlah,
            'id_kategori' => $request->id_kategori,
            'id_admin' => Auth::id(),
            'tipe' => $tipe,
        ]);

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil ditambahkan.');
    }

    public function edit(BukuKas $bukuKa)
    {
        $kategoriTransaksi = KategoriTransaksi::orderBy('nama_kategori')->get();
        return view('pages.buku-kas.edit', ['bukuKas' => $bukuKa, 'kategoriTransaksi' => $kategoriTransaksi]);
    }

    public function update(Request $request, BukuKas $bukuKa)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'jumlah' => 'required|numeric|min:0',
            'id_kategori' => 'nullable|exists:kategori_transaksis,id',
            'tipe' => 'required_if:id_kategori,null|in:pemasukan,pengeluaran',
        ]);
        
        $tipe = $request->tipe;
        if ($request->filled('id_kategori')) {
            $kategori = KategoriTransaksi::find($request->id_kategori);
            $tipe = $kategori->tipe;
        }

        $bukuKa->update([
            'tanggal' => $request->tanggal,
            'deskripsi' => $request->deskripsi,
            'jumlah' => $request->jumlah,
            'id_kategori' => $request->id_kategori,
            'tipe' => $tipe,
        ]);

        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil diperbarui.');
    }

    public function destroy(BukuKas $bukuKa)
    {
        $bukuKa->delete();
        return redirect()->route('buku-kas.index')->with('success', 'Transaksi berhasil dihapus.');
    }

    public function exportExcel(Request $request)
    {
        $bulan = $request->input('bulan', date('Y-m'));
        return Excel::download(new BukuKasExport($bulan), 'buku-kas-' . $bulan . '.xlsx');
    }

    public function exportPdf(Request $request)
    {
        $selectedMonth = $request->get('bulan', Carbon::now()->format('Y-m'));
        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $bukuKas = BukuKas::with('kategori')
            ->whereBetween('tanggal', [$startDate, $endDate])
            ->latest('tanggal')
            ->get();
            
        $totalPemasukan = $bukuKas->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = $bukuKas->where('tipe', 'pengeluaran')->sum('jumlah');
        
        // PERBAIKAN: Mengganti nama variabel agar konsisten
        $saldoAkhir = $totalPemasukan - $totalPengeluaran;

        $pdf = PDF::loadView('pages.buku-kas.buku-kas-pdf', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'startDate', 'endDate'));
        return $pdf->download('buku-kas-' . $selectedMonth . '.pdf');
    }
}