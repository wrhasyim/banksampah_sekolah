<?php

namespace App\Http\Controllers;

use App\Exports\SetoranSampleExport;
use App\Imports\SetoranImport;
use App\Models\JenisSampah;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class SetoranController extends Controller
{
    /**
     * PERBAIKAN: Method untuk menampilkan form impor.
     */
    public function showImportForm()
    {
        return view('pages.setoran.import');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xls,xlsx'
        ]);

        Excel::import(new SetoranImport, $request->file('file'));

        return redirect()->route('setoran.index')->with('success', 'Data setoran berhasil diimpor!');
    }
    
    public function sampleExport()
    {
        return Excel::download(new SetoranSampleExport, 'sample-setoran.xlsx');
    }
    
    public function index()
    {
        $setoran = Setoran::with(['siswa.pengguna', 'jenisSampah'])->latest()->get();
        return view('pages.setoran.index', compact('setoran'));
    }

    public function create()
    {
        return view('pages.setoran.create', [
            'siswa' => Siswa::all(),
            'jenisSampah' => JenisSampah::all(),
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'siswa_id' => 'required|exists:siswa,id',
            'id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'jumlah' => 'required|numeric',
        ]);

        $jenisSampah = JenisSampah::find($request->id_jenis_sampah);
        $totalHarga = $jenisSampah->harga_per_kg * $request->jumlah;

        $setoran = Setoran::create([
            'siswa_id' => $request->siswa_id,
            'id_jenis_sampah' => $request->id_jenis_sampah,
            'jumlah' => $request->jumlah,
            'total_harga' => $totalHarga,
            'id_admin' => auth()->id(),
            'tanggal_setor' => now(),
        ]);
        
        $siswa = Siswa::find($request->siswa_id);
        $siswa->saldo += $totalHarga;
        $siswa->save();

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil ditambahkan.');
    }

    public function destroy(Setoran $setoran)
    {
        $siswa = Siswa::find($setoran->siswa_id);
        $siswa->saldo -= $setoran->total_harga;
        $siswa->save();
        
        $setoran->delete();

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil dihapus.');
    }
}