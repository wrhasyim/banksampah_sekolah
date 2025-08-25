<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Imports\SetoranImport;
use Maatwebsite\Excel\Validators\ValidationException;
use App\Exports\SetoranSampleExport;

class SetoranController extends Controller
{
    public function index()
    {
        $setoran = Setoran::with(['siswa.pengguna', 'jenisSampah', 'admin'])->latest()->get();
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
            'jumlah' => 'required|numeric|min:0.01',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $siswa = Siswa::findOrFail($request->id_siswa);
                $jenisSampah = JenisSampah::findOrFail($request->id_jenis_sampah);

                $totalHarga = $jenisSampah->harga_per_satuan * $request->jumlah;

                Setoran::create([
                    'id_siswa' => $request->id_siswa,
                    'id_jenis_sampah' => $request->id_jenis_sampah,
                    'id_admin' => Auth::id(),
                    'jumlah' => $request->jumlah,
                    'total_harga' => $totalHarga,
                ]);

                $siswa->increment('saldo', $totalHarga);
                $jenisSampah->increment('stok', $request->jumlah);
            });
        } catch (\Exception $e) {
            return redirect()->route('setoran.create')->with('toastr-error', 'Terjadi kesalahan saat menyimpan transaksi.');
        }

        return redirect()->route('setoran.index')->with('toastr-success', 'Transaksi setoran berhasil disimpan!');
    }

    // --- METODE YANG HILANG DIKEMBALIKAN DI SINI ---
    
    public function showImportForm()
    {
        $jenisSampah = \App\Models\JenisSampah::take(2)->get();
        $siswa = \App\Models\Siswa::with(['pengguna', 'kelas'])->take(2)->get();
        return view('pages.setoran.import', compact('jenisSampah', 'siswa'));
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        try {
            \Maatwebsite\Excel\Facades\Excel::import(new SetoranImport, $request->file('file'));
        
        } catch (ValidationException $e) {
            $failures = $e->failures();
            $errorMessages = [];
            foreach ($failures as $failure) {
                $errorMessages[] = 'Baris ' . $failure->row() . ': ' . implode(', ', $failure->errors());
            }
            return redirect()->route('setoran.import.form')->withErrors($errorMessages);
        }

        return redirect()->route('setoran.import.form')->with('success', 'Data setoran berhasil diimpor!');
    }

    public function exportSample()
    {
        return \Maatwebsite\Excel\Facades\Excel::download(new SetoranSampleExport, 'contoh-impor-setoran.xlsx');
    }
}