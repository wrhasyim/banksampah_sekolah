<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\Pengguna;
use App\Models\Kelas;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;

class InsentifController extends Controller
{
    public function index(Request $request) // <-- Tambahkan Request
    {
        // Ambil tanggal dari request atau gunakan default bulan ini
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $query = Insentif::with(['setoran.siswa.pengguna', 'kelas.waliKelas']);

        // Terapkan filter tanggal jika diisi
        if ($request->filled('start_date') && $request->filled('end_date')) {
            $query->whereBetween('created_at', [$startDate, $endDate]);
        }

        $insentifs = $query->latest()->paginate(15);
        $kelas = Kelas::orderBy('nama_kelas')->get();

        // Kirim semua variabel yang dibutuhkan ke view
        return view('pages.insentif.index', compact('insentifs', 'kelas', 'startDate', 'endDate'));
    }

    public function rekap(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        $rekapWaliKelas = Insentif::with('kelas.waliKelas')
            ->whereBetween('created_at', [$start, $end])
            ->whereHas('kelas.waliKelas')
            ->get()
            ->groupBy('kelas.waliKelas.nama_lengkap')
            ->map(function ($items, $namaWaliKelas) {
                return [
                    'nama_wali_kelas' => $namaWaliKelas,
                    'total_insentif' => $items->sum('jumlah_insentif'),
                    'sudah_dibayar' => $items->where('status_pembayaran', 'sudah dibayar')->sum('jumlah_insentif'),
                    'belum_dibayar' => $items->where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif'),
                ];
            })->values();

        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])
                                    ->latest('tanggal')
                                    ->paginate(10, ['*'], 'pengelola_page');

        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])
                                  ->latest('tanggal')
                                  ->paginate(10, ['*'], 'sekolah_page');
        
        $totalWaliKelas = $rekapWaliKelas->sum('total_insentif');
        $totalPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');
        $totalSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')->whereBetween('tanggal', [$start, $end])->sum('jumlah');

        return view('pages.insentif.rekap', compact(
            'rekapWaliKelas',
            'insentifPengelola', 
            'insentifSekolah', 
            'totalWaliKelas',
            'totalPengelola', 
            'totalSekolah', 
            'startDate', 
            'endDate'
        ));
    }

    public function exportPdf(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $start = Carbon::parse($startDate)->startOfDay();
        $end = Carbon::parse($endDate)->endOfDay();

        $rekapWaliKelas = Insentif::with('kelas.waliKelas')
            ->whereBetween('created_at', [$start, $end])
            ->whereHas('kelas.waliKelas')
            ->get()
            ->groupBy('kelas.waliKelas.nama_lengkap')
            ->map(function ($items, $namaWaliKelas) {
                return [
                    'nama_wali_kelas' => $namaWaliKelas,
                    'total_insentif' => $items->sum('jumlah_insentif'),
                    'sudah_dibayar' => $items->where('status_pembayaran', 'sudah dibayar')->sum('jumlah_insentif'),
                    'belum_dibayar' => $items->where('status_pembayaran', 'belum dibayar')->sum('jumlah_insentif'),
                ];
            })->values();

        $insentifPengelola = BukuKas::where('deskripsi', 'like', 'Honor Pengelola%')
                                    ->whereBetween('tanggal', [$start, $end])->latest('tanggal')->get();

        $insentifSekolah = BukuKas::where('deskripsi', 'like', 'Honor Sekolah%')
                                  ->whereBetween('tanggal', [$start, $end])->latest('tanggal')->get();
        
        $totalWaliKelas = $rekapWaliKelas->sum('total_insentif');
        $totalPengelola = $insentifPengelola->sum('jumlah');
        $totalSekolah = $insentifSekolah->sum('jumlah');

        $pdf = Pdf::loadView('pages.insentif.insentif-rekap-pdf', compact(
            'rekapWaliKelas',
            'insentifPengelola',
            'insentifSekolah',
            'totalWaliKelas',
            'totalPengelola',
            'totalSekolah',
            'startDate',
            'endDate'
        ));

        return $pdf->stream('rekap-insentif-gabungan-' . $startDate . '-sd-' . $endDate . '.pdf');
    }

    public function destroy(Insentif $insentif)
    {
        $insentif->delete();
        return redirect()->route('insentif.index')->with('success', 'Data insentif berhasil di-void (dihapus).');
    }

    public function voidPerKelas(Request $request)
    {
        $request->validate([
            'kelas_id' => 'required|exists:kelas,id',
            'tanggal' => 'required|date',
        ]);

        $kelasId = $request->kelas_id;
        $tanggal = Carbon::parse($request->tanggal)->toDateString();

        $jumlahDihapus = Insentif::where('kelas_id', $kelasId)
            ->whereDate('created_at', $tanggal)
            ->delete();

        if ($jumlahDihapus > 0) {
            return redirect()->route('insentif.index')->with('success', "Sebanyak {$jumlahDihapus} data insentif untuk kelas yang dipilih pada tanggal {$tanggal} berhasil di-void.");
        }

        return redirect()->route('insentif.index')->with('error', 'Tidak ada data insentif yang cocok untuk di-void pada kelas dan tanggal tersebut.');
    }
}