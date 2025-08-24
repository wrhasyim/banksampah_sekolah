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

        if ($request->isMethod('post')) {
            $startDate = $request->start_date;
            $endDate = $request->end_date;
            $kelasId = $request->id_kelas;

            if ($tipeLaporan === 'transaksi') {
                // Proses data setoran
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
                        'kredit' => $item->total_harga,
                        'debit' => 0,
                    ]);
                
                // Proses data penarikan (dengan logika baru)
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
                        'kredit' => 0,
                        'debit' => $item->jumlah_penarikan,
                    ]);
                
                $results = $setoran->concat($penarikan)->sortByDesc('tanggal');

            } elseif ($tipeLaporan === 'penjualan') {
                // ... (logika penjualan tetap sama)
            }
        }

        return view('pages.laporan.index', compact('kelas', 'results', 'tipeLaporan'));
    }

    // ... (sisa file controller tetap sama)
}