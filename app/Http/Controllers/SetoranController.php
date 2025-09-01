<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas;
use App\Models\Setting;
use App\Models\BukuKas;
use App\Models\Insentif;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Imports\SetoranImport;
use App\Exports\SetoranSampleExport;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class SetoranController extends Controller
{
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
            $siswa = Siswa::with('kelas', 'pengguna')->find($request->siswa_id);

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

                $jenisSampah->increment('stok', $item['jumlah']);

                if ($persentaseWaliKelas > 0 && $siswa->kelas && $siswa->kelas->id_wali_kelas) {
                    $insentifWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);

                    if ($insentifWaliKelas > 0) {
                        Insentif::create([
                            'setoran_id' => $setoran->id,
                            'kelas_id' => $siswa->id_kelas,
                            'jumlah_insentif' => $insentifWaliKelas,
                        ]);
                    }
                }
            }
            $siswa->increment('saldo', $totalHargaKeseluruhan);
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil ditambahkan.');
    }

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
            return ['id' => $item->id, 'text' => $item->pengguna->nama_lengkap . ' (' . ($item->kelas->nama_kelas ?? 'Tanpa Kelas') . ')'];
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
        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();
    
        // Ambil semua jenis sampah yang aktif
        $allJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();

        // Pisahkan jenis sampah untuk siswa dan guru berdasarkan nama
        $jenisSampahSiswa = $allJenisSampah->filter(function ($value, $key) {
            // Ambil sampah yang namanya TIDAK mengandung kata 'Guru' (case-insensitive)
            return strpos(strtolower($value->nama_sampah), 'guru') === false;
        });

        $jenisSampahGuru = $allJenisSampah->filter(function ($value, $key) {
            // Ambil sampah yang namanya MENGANDUNG kata 'Guru' (case-insensitive)
            return strpos(strtolower($value->nama_sampah), 'guru') !== false;
        });
        
        return view('pages.setoran.create-massal', compact(
            'kelasList', 
            'jenisSampahSiswa', 
            'jenisSampahGuru'
        ));
    }

    public function storeMassal(Request $request)
    {
        $request->validate([
            'setoran' => 'required|array',
            'setoran.*.*' => 'nullable|numeric|min:0',
        ]);

        DB::transaction(function () use ($request) {
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            foreach ($request->setoran as $siswa_id => $sampahData) {
                $totalHargaKeseluruhanSiswa = 0;
                $siswa = Siswa::with('kelas', 'pengguna')->find($siswa_id);

                if (!$siswa) continue;

                foreach ($sampahData as $jenis_sampah_id => $jumlah) {
                    if (!empty($jumlah) && $jumlah > 0) {
                        $jenisSampah = JenisSampah::find($jenis_sampah_id);
                        if (!$jenisSampah) continue;

                        $totalHarga = $jumlah * $jenisSampah->harga_per_satuan;
                        $totalHargaKeseluruhanSiswa += $totalHarga;

                        $setoran = Setoran::create([
                            'siswa_id' => $siswa_id,
                            'jenis_sampah_id' => $jenis_sampah_id,
                            'jumlah' => $jumlah,
                            'total_harga' => $totalHarga,
                        ]);

                        $jenisSampah->increment('stok', $jumlah);

                        if ($persentaseWaliKelas > 0 && $siswa->kelas && $siswa->kelas->id_wali_kelas) {
                            $insentifWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);

                            if ($insentifWaliKelas > 0) {
                                Insentif::create([
                                    'setoran_id' => $setoran->id,
                                    'kelas_id' => $siswa->id_kelas,
                                    'jumlah_insentif' => $insentifWaliKelas,
                                ]);
                            }
                        }
                    }
                }

                if ($totalHargaKeseluruhanSiswa > 0) {
                    $siswa->increment('saldo', $totalHargaKeseluruhanSiswa);
                    $points = floor($totalHargaKeseluruhanSiswa / 1000);
                    if ($points > 0) {
                        $siswa->increment('points', $points);
                    }
                }
            }
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran massal berhasil disimpan.');
    }
}