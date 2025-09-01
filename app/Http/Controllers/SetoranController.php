<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas;
use App\Models\Setting; // Tambahkan ini
use App\Models\BukuKas; // Tambahkan ini
use App\Models\Insentif; // Tambahkan ini
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Imports\SetoranImport;
use App\Exports\SetoranSampleExport;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Auth; // Tambahkan ini

class SetoranController extends Controller
{
    // ... (method index dan create tidak berubah) ...
    public function index(Request $request)
    {
        $perPage = $request->input('perPage', 10);
        $search = $request->input('search');

        $setoran = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->when($search, function ($query, $search) {
                $query->whereHas('siswa.pengguna', function ($q) use ($search) {
                    $q->where('nama_lengkap', 'like', "%{$search}%");
                });
            })
            ->latest()
            ->paginate($perPage);

        return view('pages.setoran.index', compact('setoran', 'perPage'));
    }

    public function create()
    {
        // PERBAIKAN 1: Filter jenis sampah yang aktif saja
        $jenisSampah = JenisSampah::where('status', 'aktif')->get();
        $siswa = Siswa::with('kelas')->get();
        return view('pages.setoran.create', compact('jenisSampah', 'siswa'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'siswa_id' => 'required|exists:siswa,id',
            'sampah' => 'required|array|min:1',
            'sampah.*.jenis_sampah_id' => 'required|exists:jenis_sampah,id',
            'sampah.*.jumlah' => 'required|numeric|min:0.1',
        ]);

        DB::transaction(function () use ($request) {
            $totalHargaKeseluruhan = 0;
            $siswa = Siswa::with('kelas')->find($request->siswa_id);

            // Ambil persentase insentif wali kelas
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            foreach ($request->sampah as $item) {
                $jenisSampah = JenisSampah::find($item['jenis_sampah_id']);
                $totalHarga = $jenisSampah->harga_per_satuan * $item['jumlah'];
                $totalHargaKeseluruhan += $totalHarga;

                $setoran = Setoran::create([
                    'siswa_id' => $request->siswa_id,
                    'jenis_sampah_id' => $item['jenis_sampah_id'],
                    'jumlah' => $item['jumlah'],
                    'total_harga' => $totalHarga,
                ]);

                // Tambah stok sampah
                $jenisSampah->increment('stok', $item['jumlah']);

                // --- LOGIKA INSENTIF BARU ---
                if ($persentaseWaliKelas > 0 && $siswa->kelas) {
                    $insentifWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);

                    if ($insentifWaliKelas > 0) {
                        Insentif::create([
                            'setoran_id' => $setoran->id,
                            'kelas_id' => $siswa->id_kelas,
                            'jumlah_insentif' => $insentifWaliKelas,
                        ]);

                        BukuKas::create([
                            'tanggal' => now(),
                            'deskripsi' => 'Insentif Wali Kelas: ' . $siswa->kelas->nama_kelas . ' (dari Setoran Siswa: ' . $siswa->pengguna->nama_lengkap . ')',
                            'tipe' => 'pengeluaran',
                            'jumlah' => $insentifWaliKelas,
                            'id_admin' => Auth::id(),
                        ]);
                    }
                }
            }
            // Update saldo siswa
            $siswa->increment('saldo', $totalHargaKeseluruhan);
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil ditambahkan.');
    }

    // ... (method getSiswa, showImportForm, import, sampleExport, createMassal tidak berubah) ...
    public function getSiswa(Request $request)
    {
        $search = $request->input('q');
        $siswa = Siswa::with('pengguna', 'kelas')
            ->whereHas('pengguna', function ($query) use ($search) {
                $query->where('nama_lengkap', 'LIKE', "%{$search}%")
                    ->orWhere('username', 'LIKE', "%{$search}%");
            })
            ->limit(10)
            ->get();

        $formattedSiswa = $siswa->map(function ($item) {
            return ['id' => $item->id, 'text' => $item->pengguna->nama_lengkap . ' (' . $item->kelas->nama_kelas . ')'];
        });

        return response()->json($formattedSiswa);
    }

    public function showImportForm()
    {
        return view('pages.setoran.import');
    }

    public function import(Request $request)
    {
        $request->validate(['file' => 'required|mimes:xls,xlsx']);
        try {
            Excel::import(new SetoranImport, $request->file('file'));
        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan saat mengimpor: ' . $e->getMessage());
        }
        return redirect()->route('setoran.index')->with('success', 'Data setoran berhasil diimpor!');
    }

    public function sampleExport()
    {
        return Excel::download(new SetoranSampleExport, 'sample-setoran.xlsx');
    }

    public function createMassal()
    {
        // PERBAIKAN 2: Filter jenis sampah yang aktif saja
        $jenisSampahs = JenisSampah::where('status', 'aktif')->get();
        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();
        
        return view('pages.setoran.create-massal', compact('jenisSampahs', 'kelasList'));
    }
    public function storeMassal(Request $request)
    {
        $request->validate([
            'jenis_sampah_id' => 'required|exists:jenis_sampah,id',
            'setoran' => 'required|array',
            'setoran.*.siswa_id' => 'required|exists:siswa,id',
            'setoran.*.jumlah' => 'nullable|numeric|min:0',
        ]);

        $jenisSampah = JenisSampah::find($request->jenis_sampah_id);
        
        DB::transaction(function () use ($request, $jenisSampah) {
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            foreach ($request->setoran as $data) {
                if (!empty($data['jumlah']) && $data['jumlah'] > 0) {
                    $totalHarga = $data['jumlah'] * $jenisSampah->harga_per_satuan;
                    $siswa = Siswa::with('kelas', 'pengguna')->find($data['siswa_id']);

                    $setoran = Setoran::create([
                        'siswa_id' => $data['siswa_id'],
                        'jenis_sampah_id' => $jenisSampah->id,
                        'jumlah' => $data['jumlah'],
                        'total_harga' => $totalHarga,
                    ]);

                    // Tambah stok sampah
                    $jenisSampah->increment('stok', $data['jumlah']);

                    // Update saldo dan poin siswa
                    $siswa->increment('saldo', $totalHarga);
                    $points = floor($totalHarga / 1000);
                    if ($points > 0) {
                        $siswa->increment('points', $points);
                    }

                    // --- LOGIKA INSENTIF BARU ---
                    if ($persentaseWaliKelas > 0 && $siswa->kelas) {
                        $insentifWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);

                        if ($insentifWaliKelas > 0) {
                            Insentif::create([
                                'setoran_id' => $setoran->id,
                                'kelas_id' => $siswa->id_kelas,
                                'jumlah_insentif' => $insentifWaliKelas,
                            ]);

                            BukuKas::create([
                                'tanggal' => now(),
                                'deskripsi' => 'Insentif Wali Kelas: ' . $siswa->kelas->nama_kelas . ' (dari Setoran Massal: ' . $siswa->pengguna->nama_lengkap . ')',
                                'tipe' => 'pengeluaran',
                                'jumlah' => $insentifWaliKelas,
                                'id_admin' => Auth::id(),
                            ]);
                        }
                    }
                }
            }
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran massal berhasil disimpan.');
    }
}