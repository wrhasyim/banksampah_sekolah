<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas; // TAMBAHKAN BARIS INI
use Illuminate\Http\Request;
use App\Exports\SetoranExport;
use App\Imports\SetoranImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\SetoranSampleExport;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;

class SetoranController extends Controller
{
    public function index()
    {
        $setorans = Setoran::with(['siswa.pengguna', 'jenisSampah'])->latest()->paginate(10);
        return view('pages.setoran.index', compact('setorans'));
    }

    public function create()
    {
        $siswas = Siswa::with('pengguna')->get();
        $jenisSampahs = JenisSampah::all();
        return view('pages.setoran.create', compact('siswas', 'jenisSampahs'));
    }
    
    // FUNGSI BARU UNTUK MENAMPILKAN FORM SETORAN MASSAL
    public function createMassal()
    {
        $jenisSampahs = JenisSampah::all();
        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.setoran.create-massal', compact('jenisSampahs', 'kelasList'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'siswa_id' => 'required|exists:siswa,id',
            'jenis_sampah_id' => 'required|exists:jenis_sampah,id',
            'jumlah' => 'required|numeric|min:0',
        ]);

        $jenisSampah = JenisSampah::find($request->jenis_sampah_id);
        $totalHarga = $request->jumlah * $jenisSampah->harga_per_kg;

        DB::transaction(function () use ($request, $totalHarga) {
            Setoran::create([
                'siswa_id' => $request->siswa_id,
                'jenis_sampah_id' => $request->jenis_sampah_id,
                'jumlah' => $request->jumlah,
                'total_harga' => $totalHarga,
            ]);

            $siswa = Siswa::find($request->siswa_id);
            $siswa->increment('saldo', $totalHarga);
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil ditambahkan.');
    }

    // FUNGSI BARU UNTUK MENYIMPAN DATA DARI FORM SETORAN MASSAL
    public function storeMassal(Request $request)
    {
        $request->validate([
            'jenis_sampah_id' => 'required|exists:jenis_sampah,id',
            'setoran' => 'required|array',
            'setoran.*.siswa_id' => 'required|exists:siswa,id',
            'setoran.*.jumlah' => 'required|numeric|min:0',
        ]);

        $jenisSampah = JenisSampah::find($request->jenis_sampah_id);
        
        DB::transaction(function () use ($request, $jenisSampah) {
            foreach ($request->setoran as $data) {
                if ($data['jumlah'] > 0) {
                    $totalHarga = $data['jumlah'] * $jenisSampah->harga_per_kg;

                    Setoran::create([
                        'siswa_id' => $data['siswa_id'],
                        'jenis_sampah_id' => $jenisSampah->id,
                        'jumlah' => $data['jumlah'],
                        'total_harga' => $totalHarga,
                    ]);

                    $siswa = Siswa::find($data['siswa_id']);
                    $siswa->increment('saldo', $totalHarga);
                }
            }
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran massal berhasil disimpan.');
    }

    public function destroy(Setoran $setoran)
    {
        DB::transaction(function () use ($setoran) {
            $siswa = Siswa::find($setoran->siswa_id);
            if ($siswa->saldo >= $setoran->total_harga) {
                $siswa->decrement('saldo', $setoran->total_harga);
            } else {
                $siswa->update(['saldo' => 0]);
            }
            $setoran->delete();
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil dihapus.');
    }

    public function export()
    {
        return Excel::download(new SetoranExport, 'setoran.xlsx');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        try {
            $jenisSampah = JenisSampah::all();
            Excel::import(new SetoranImport($jenisSampah), $request->file('file'));
            return redirect()->route('setoran.index')->with('success', 'Data setoran berhasil diimpor.');
        } catch (\Exception $e) {
            return redirect()->route('setoran.index')->with('error', 'Terjadi kesalahan saat mengimpor data: ' . $e->getMessage());
        }
    }

    public function showImportForm()
    {
        return view('pages.setoran.import');
    }
    
    public function downloadSample()
    {
        return Excel::download(new SetoranSampleExport, 'sample_setoran.xlsx');
    }

    public function cetakPdf()
    {
        $setorans = Setoran::with(['siswa.pengguna', 'jenisSampah'])->latest()->get();
        $pdf = Pdf::loadView('pages.setoran.pdf', compact('setorans'));
        return $pdf->download('laporan-setoran.pdf');
    }
}