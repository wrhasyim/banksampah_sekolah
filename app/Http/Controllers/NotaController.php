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
     * Menampilkan halaman form untuk memilih bulan dan kelas.
     */
    public function index()
    {
        $kelas = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.nota.index', compact('kelas'));
    }

    /**
     * Membuat dan mencetak nota dalam format PDF.
     */
    public function cetak(Request $request)
    {
        $request->validate([
            'bulan' => 'required|date_format:Y-m',
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        $selectedMonth = $request->input('bulan');
        $id_kelas = $request->input('id_kelas');

        $startDate = Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $selectedMonth)->endOfMonth();

        $kelas = Kelas::with('waliKelas')->findOrFail($id_kelas);

        // Mengambil data setoran, dikelompokkan per jenis sampah
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
            return back()->with('toastr-error', 'Tidak ada data setoran untuk kelas dan bulan yang dipilih.');
        }

        $pdf = PDF::loadView('pages.nota.pdf', compact('kelas', 'selectedMonth', 'rincianSetoran', 'totalKeseluruhan'));
        
        // Membuat nama file yang deskriptif
        $namaFile = 'nota-' . $kelas->nama_kelas . '-' . $selectedMonth . '.pdf';

        return $pdf->stream($namaFile);
    }
}