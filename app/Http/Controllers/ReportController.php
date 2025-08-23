<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Kelas;
use App\Exports\SetoranReportExport;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $kelas = Kelas::all();
        $setoran = collect();

        if ($request->isMethod('post')) {
            $query = Setoran::with(['siswa.pengguna', 'jenis_sampah', 'admin']);

            if ($request->filled('start_date')) {
                $query->whereDate('created_at', '>=', $request->start_date);
            }
            if ($request->filled('end_date')) {
                $query->whereDate('created_at', '<=', $request->end_date);
            }
            if ($request->filled('id_kelas')) {
                $query->whereHas('siswa', function ($q) use ($request) {
                    $q->where('id_kelas', $request->id_kelas);
                });
            }

            $setoran = $query->latest()->get();
        }

        return view('pages.laporan.setoran', compact('kelas', 'setoran'));
    }

    public function exportSetoran(Request $request)
    {
        $query = Setoran::with(['siswa.pengguna', 'jenis_sampah', 'admin']);

        if ($request->filled('start_date')) {
            $query->whereDate('created_at', '>=', $request->start_date);
        }
        if ($request->filled('end_date')) {
            $query->whereDate('created_at', '<=', $request->end_date);
        }
        if ($request->filled('id_kelas')) {
            $query->whereHas('siswa', function ($q) use ($request) {
                $q->where('id_kelas', $request->id_kelas);
            });
        }

        return Excel::download(new SetoranReportExport($query->get()), 'laporan-setoran.xlsx');
    }
}