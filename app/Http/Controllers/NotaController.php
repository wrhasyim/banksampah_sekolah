<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Setoran;
use App\Models\Setting;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class NotaController extends Controller
{
    public function index()
    {
        $kelas = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.nota.index', compact('kelas'));
    }

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

        $rincianSetoran = Setoran::where('status', '!=', 'terlambat')
            ->whereHas('siswa', function ($query) use ($id_kelas) {
                $query->where('id_kelas', $id_kelas);
            })
            ->whereBetween('created_at', [$startDate, $endDate])
            ->with('jenisSampah')
            ->select(
                'jenis_sampah_id',
                DB::raw('SUM(jumlah) as total_jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->groupBy('jenis_sampah_id')
            ->get();
        
        $totalKeseluruhan = $rincianSetoran->sum('total_harga');

        if ($rincianSetoran->isEmpty()) {
            return back()->with('toastr-error', 'Tidak ada data setoran untuk kelas dan rentang tanggal yang dipilih.');
        }

        $settings = Setting::pluck('value', 'key');
        $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;
        $insentifWaliKelas = $totalKeseluruhan * ($persentaseWaliKelas / 100);

        $pdf = PDF::loadView('pages.nota.pdf', compact('kelas', 'startDate', 'endDate', 'rincianSetoran', 'totalKeseluruhan', 'insentifWaliKelas', 'persentaseWaliKelas'));
        
        $namaFile = 'nota-' . $kelas->nama_kelas . '-' . $startDate->format('Y-m-d') . '_sd_' . $endDate->format('Y-m-d') . '.pdf';

        return $pdf->stream($namaFile);
    }
}