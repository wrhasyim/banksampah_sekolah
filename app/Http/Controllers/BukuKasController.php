<?php

namespace App\Http\Controllers;

use App\Models\BukuKas;
use Illuminate\Http\Request;
use App\Exports\BukuKasExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;
use App\Models\KategoriTransaksi;
use App\Models\SaldoBulanan; // <-- TAMBAHKAN INI
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

        // --- PERUBAHAN LOGIKA SALDO ---
        $saldoTerakhirDitutup = SaldoBulanan::latest('periode')->first();
        $saldoAwal = $saldoTerakhirDitutup ? $saldoTerakhirDitutup->saldo_akhir : 0;
        $tanggalMulaiHitung = $saldoTerakhirDitutup ? Carbon::parse($saldoTerakhirDitutup->periode)->addMonth()->startOfMonth() : '1970-01-01';

        // Saldo akhir adalah saldo terakhir ditutup + total transaksi setelahnya
        $pemasukanSetelahTutup = BukuKas::where('tanggal', '>=', $tanggalMulaiHitung)->where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaranSetelahTutup = BukuKas::where('tanggal', '>=', $tanggalMulaiHitung)->where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAkhir = $saldoAwal + $pemasukanSetelahTutup - $pengeluaranSetelahTutup;
        // --- AKHIR PERUBAHAN LOGIKA SALDO ---
        
        $totalPemasukan = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pemasukan')->sum('jumlah');
        $totalPengeluaran = BukuKas::whereBetween('tanggal', [$startDate, $endDate])->where('tipe', 'pengeluaran')->sum('jumlah');
        
        $kategoriTransaksi = KategoriTransaksi::orderBy('nama_kategori')->get();

        return view('pages.buku-kas.index', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'kategoriTransaksi'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'deskripsi' => 'required|string|max:255',
            'jumlah' => 'required|numeric|min:0',
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
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
    
    // ... (method edit, update, destroy, exportExcel tidak berubah) ...
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
            'id_kategori' => 'nullable|exists:kategori_transaksi,id',
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
        
        // --- PERUBAHAN LOGIKA SALDO PDF ---
        $saldoTerakhirDitutup = SaldoBulanan::where('periode', '<', $startDate)->latest('periode')->first();
        $saldoAwalBulan = $saldoTerakhirDitutup ? $saldoTerakhirDitutup->saldo_akhir : 0;
        $tanggalMulaiHitung = $saldoTerakhirDitutup ? Carbon::parse($saldoTerakhirDitutup->periode)->addMonth()->startOfMonth() : '1970-01-01';
        
        $pemasukanSisa = BukuKas::whereBetween('tanggal', [$tanggalMulaiHitung, $startDate->copy()->subDay()])->where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaranSisa = BukuKas::whereBetween('tanggal', [$tanggalMulaiHitung, $startDate->copy()->subDay()])->where('tipe', 'pengeluaran')->sum('jumlah');
        $saldoAwalBulan += ($pemasukanSisa - $pengeluaranSisa);
        // --- AKHIR PERUBAHAN LOGIKA SALDO PDF ---

        $saldoAkhir = $saldoAwalBulan + $totalPemasukan - $totalPengeluaran;

        $pdf = PDF::loadView('pages.buku-kas.buku-kas-pdf', compact('bukuKas', 'selectedMonth', 'totalPemasukan', 'totalPengeluaran', 'saldoAkhir', 'saldoAwalBulan'));
        return $pdf->download('buku-kas-' . $selectedMonth . '.pdf');
    }

    public function getChartData()
    {
        $data = BukuKas::select(
                DB::raw('YEAR(tanggal) as year'),
                DB::raw('MONTH(tanggal) as month'),
                DB::raw("SUM(CASE WHEN tipe = 'pemasukan' THEN jumlah ELSE 0 END) as pemasukan"),
                DB::raw("SUM(CASE WHEN tipe = 'pengeluaran' THEN jumlah ELSE 0 END) as pengeluaran")
            )
            ->where('tanggal', '>=', Carbon::now()->subMonths(11)->startOfMonth())
            ->groupBy('year', 'month')
            ->orderBy('year', 'asc')
            ->orderBy('month', 'asc')
            ->get();

        $labels = [];
        $pemasukanData = [];
        $pengeluaranData = [];

        $date = Carbon::now()->subMonths(11)->startOfMonth();
        for ($i = 0; $i < 12; $i++) {
            $monthLabel = $date->isoFormat('MMM YYYY');
            $labels[] = $monthLabel;
            $pemasukanData[$monthLabel] = 0;
            $pengeluaranData[$monthLabel] = 0;
            $date->addMonth();
        }
        
        foreach ($data as $row) {
            $monthLabel = Carbon::createFromDate($row->year, $row->month, 1)->isoFormat('MMM YYYY');
            if (isset($pemasukanData[$monthLabel])) {
                $pemasukanData[$monthLabel] = $row->pemasukan;
                $pengeluaranData[$monthLabel] = $row->pengeluaran;
            }
        }
        
        return response()->json([
            'labels' => $labels,
            'pemasukan' => array_values($pemasukanData),
            'pengeluaran' => array_values($pengeluaranData),
        ]);
    }
}