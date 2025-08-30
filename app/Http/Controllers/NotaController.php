<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Setoran;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class NotaController extends Controller
{
    /**
     * Menampilkan halaman form untuk memilih rentang tanggal dan kelas.
     */
    public function index()
    {
        $kelas = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.nota.index', compact('kelas'));
    }

    /**
     * Membuat dan mencetak nota dalam format PDF berdasarkan rentang tanggal.
     */
    public function cetak(Request $request)
    {
        $request->validate([
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        $startDate = Carbon::parse($request->input('start_date'))->startOfDay();
        $endDate = Carbon::parse($request->input('end_date'))->endOfDay();
        $id_kelas = $request->input('id_kelas');

        $kelas = Kelas::with('waliKelas')->findOrFail($id_kelas);

        $rincianSetoran = Setoran::whereHas('siswa', function ($query) use ($id_kelas) {
                $query->where('id_kelas', $id_kelas);
            })
            ->whereBetween('created_at', [$startDate, $endDate])
            ->with('jenisSampah')
            ->select(
                'id_jenis_sampah',
                DB::raw('SUM(berat) as total_berat'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->groupBy('id_jenis_sampah')
            ->get();
        
        $totalKeseluruhan = $rincianSetoran->sum('total_harga');

        if ($rincianSetoran->isEmpty()) {
            return back()->with('toastr-error', 'Tidak ada data setoran untuk kelas dan rentang tanggal yang dipilih.');
        }

        $pdf = PDF::loadView('pages.nota.pdf', compact('kelas', 'startDate', 'endDate', 'rincianSetoran', 'totalKeseluruhan'));
        
        $namaFile = 'nota-' . $kelas->nama_kelas . '-' . $startDate->format('Y-m-d') . '_sd_' . $endDate->format('Y-m-d') . '.pdf';

        return $pdf->stream($namaFile);
    }
}