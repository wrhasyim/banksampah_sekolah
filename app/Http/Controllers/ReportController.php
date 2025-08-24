<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Penarikan;
use App\Models\Penjualan;
use App\Models\Setoran;
use App\Exports\SetoranReportExport;
use App\Exports\PenjualanReportExport;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $tipeLaporan = $request->input('tipe', 'transaksi');
        $kelas = Kelas::all();
        $results = collect();

        // --- INI BAGIAN YANG DIPERBAIKI ---
        // Logika pengambilan data sekarang dijalankan di luar kondisi POST
        
        $startDate = $request->start_date;
        $endDate = $request->end_date;
        $kelasId = $request->id_kelas;

        if ($tipeLaporan === 'transaksi') {
            $setoran = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
                ->when($startDate, fn($q) => $q->whereDate('created_at', '>=', $startDate))
                ->when($endDate, fn($q) => $q->whereDate('created_at', '<=', $endDate))
                ->when($kelasId, fn($q) => $q->whereHas('siswa', fn($sq) => $sq->where('id_kelas', $kelasId)))
                ->get()
                ->map(fn($item) => (object)[
                    'tanggal' => $item->created_at,
                    'nama_siswa' => $item->siswa?->pengguna?->nama_lengkap ?? 'Siswa Dihapus',
                    'nama_kelas' => $item->siswa?->kelas?->nama_kelas ?? '-',
                    'deskripsi' => 'Setoran: ' . ($item->jenisSampah?->nama_sampah ?? '[Sampah Dihapus]'),
                    'kredit' => $item->total_harga, 'debit' => 0,
                ]);
            
            $penarikan = Penarikan::with(['siswa.pengguna', 'siswa.kelas', 'kelas'])
                ->when($startDate, fn($q) => $q->whereDate('created_at', '>=', $startDate))
                ->when($endDate, fn($q) => $q->whereDate('created_at', '<=', $endDate))
                ->when($kelasId, fn($q) => $q->where(function ($query) use ($kelasId) {
                    $query->whereHas('siswa', fn($sq) => $sq->where('id_kelas', $kelasId))
                            ->orWhere('id_kelas', $kelasId);
                }))
                ->get()
                ->map(fn($item) => (object)[
                    'tanggal' => $item->created_at,
                    'nama_siswa' => $item->id_kelas ? 'Penarikan Saldo Kelas' : ($item->siswa?->pengguna?->nama_lengkap ?? 'Siswa Dihapus'),
                    'nama_kelas' => $item->id_kelas ? $item->kelas?->nama_kelas : ($item->siswa?->kelas?->nama_kelas ?? '-'),
                    'deskripsi' => 'Penarikan Saldo',
                    'kredit' => 0, 'debit' => $item->jumlah_penarikan,
                ]);
            
            $results = $setoran->concat($penarikan)->sortByDesc('tanggal');

        } elseif ($tipeLaporan === 'penjualan') {
            $results = Penjualan::with('admin')
                ->when($startDate, fn($q) => $q->whereDate('created_at', '>=', $startDate))
                ->when($endDate, fn($q) => $q->whereDate('created_at', '<=', $endDate))
                ->latest()->get();
        }

        return view('pages.laporan.index', compact('kelas', 'results', 'tipeLaporan'));
    }

    // ... sisa file controller tetap sama ...
    public function export(Request $request)
    {
        $tipeLaporan = $request->input('tipe_export');

        if ($tipeLaporan === 'transaksi') {
            // Kita akan perbaiki ini agar bisa mengekspor gabungan data nanti
            return Excel::download(new SetoranReportExport($this->getFilteredSetoran($request)), 'laporan-setoran.xlsx');

        } elseif ($tipeLaporan === 'penjualan') {
            $penjualan = Penjualan::with('admin')
                ->when($request->filled('start_date'), fn($q) => $q->whereDate('created_at', '>=', $request->start_date))
                ->when($request->filled('end_date'), fn($q) => $q->whereDate('created_at', '<=', $request->end_date))
                ->latest()->get();
            return Excel::download(new PenjualanReportExport($penjualan), 'laporan-penjualan.xlsx');
        }

        return redirect()->back();
    }
    
    private function getFilteredSetoran(Request $request)
    {
        return Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah', 'admin'])
            ->when($request->filled('start_date'), fn($q) => $q->whereDate('created_at', '>=', $request->start_date))
            ->when($request->filled('end_date'), fn($q) => $q->whereDate('created_at', '<=', $request->end_date))
            ->when($request->filled('id_kelas'), fn($q) => $q->whereHas('siswa', fn($sq) => $sq->where('id_kelas', $request->id_kelas)))
            ->latest()->get();
    }
}