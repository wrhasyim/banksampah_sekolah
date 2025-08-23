<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\SetoranImport;
use App\Exports\SetoranExport;

class SetoranController extends Controller
{
    public function index()
    {
        $setoran = Setoran::with(['siswa.pengguna', 'jenis_sampah', 'admin'])
                           ->latest()
                           ->get();

        return view('pages.setoran.index', compact('setoran'));
    }

    public function create()
    {
        $kelas = Kelas::all();
        $jenisSampah = JenisSampah::all();
        return view('pages.setoran.create', compact('kelas', 'jenisSampah'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'jumlah_satuan' => 'required|integer|min:1',
        ]);

        $siswa = Siswa::with('pengguna')->findOrFail($request->id_siswa);
        $jenisSampah = JenisSampah::findOrFail($request->id_jenis_sampah);

        DB::transaction(function () use ($request, $siswa, $jenisSampah) {
            $total_harga = $request->jumlah_satuan * $jenisSampah->harga_per_satuan;

            Setoran::create([
                'id_siswa' => $siswa->id,
                'id_jenis_sampah' => $jenisSampah->id,
                'id_admin' => Auth::id(),
                'jumlah_satuan' => $request->jumlah_satuan,
                'total_harga' => $total_harga,
            ]);

            $siswa->saldo += $total_harga;
            $siswa->save();
        });

        return redirect()->route('setoran.index')->with('status', 'Setoran baru berhasil dicatat!');
    }

    public function getSiswaByKelas($id_kelas)
    {
        $siswa = Siswa::with('pengguna')
                      ->where('id_kelas', $id_kelas)
                      ->get()
                      ->map(function ($item) {
                          return [
                              'id' => $item->id,
                              'nama' => $item->pengguna->nama_lengkap,
                          ];
                      });
        return response()->json($siswa);
    }
    
    public function showImportForm()
    {
        return view('pages.setoran.import');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        Excel::import(new SetoranImport, $request->file('file'));

        return redirect()->route('setoran.index')->with('status', 'Data setoran berhasil diimpor!');
    }

    public function exportSample()
    {
        return Excel::download(new SetoranExport, 'setoran-template.xlsx');
    }
}