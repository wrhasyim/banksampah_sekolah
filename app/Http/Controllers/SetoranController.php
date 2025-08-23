<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Setoran;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Imports\SetoranImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SetoranExport;

class SetoranController extends Controller
{
    public function index()
    {
        // Ambil data setoran, urutkan dari yang terbaru
        // Eager load relasi untuk efisiensi query
        $setoran = Setoran::with(['siswa.pengguna', 'jenisSampah', 'admin'])->latest()->get();
        return view('pages.setoran.index', compact('setoran'));
    }

    public function exportSample()
    {
        return Excel::download(new SetoranExport, 'setoran-template.xlsx');
    }

public function showImportForm()
    {
        $siswas = Siswa::all();
        $jenisSampahs = JenisSampah::all();
        return view('pages.setoran.import', compact('siswas', 'jenisSampahs'));
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        Excel::import(new SetoranImport, $request->file('file'));

        return redirect()->route('setoran.index')->with('success', 'Data setoran sampah berhasil diimpor!');
    }
    
    public function create()
    {
        // Ambil data siswa dan jenis sampah untuk form dropdown
        $siswa = Siswa::with('pengguna')->get();
        $jenisSampah = JenisSampah::all();
        return view('pages.setoran.create', compact('siswa', 'jenisSampah'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'jumlah_satuan' => 'required|numeric|min:1',
        ]);

        try {
            // Gunakan transaksi untuk memastikan integritas data
            DB::transaction(function () use ($request) {
                $siswa = Siswa::findOrFail($request->id_siswa);
                $jenisSampah = JenisSampah::findOrFail($request->id_jenis_sampah);

                // Hitung total harga
                $totalHarga = $jenisSampah->harga_per_satuan * $request->jumlah_satuan;

                // 1. Buat record setoran baru
                Setoran::create([
                    'id_siswa' => $request->id_siswa,
                    'id_jenis_sampah' => $request->id_jenis_sampah,
                    'id_admin' => Auth::id(), // Ambil id admin yang sedang login
                    'jumlah_satuan' => $request->jumlah_satuan,
                    'total_harga' => $totalHarga,
                ]);

                // 2. Tambahkan saldo siswa
                $siswa->saldo += $totalHarga;
                $siswa->save();
            });
        } catch (\Exception $e) {
            return redirect()->route('setoran.create')->with('error', 'Terjadi kesalahan saat menyimpan transaksi.');
        }

        return redirect()->route('setoran.index')->with('status', 'Transaksi setoran berhasil disimpan!');
    }
}