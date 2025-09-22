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
use App\Exports\SetoranExport;
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

        $setorans = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->when($search, function ($query, $search) {
                $query->whereHas('siswa.pengguna', function ($q) use ($search) {
                    $q->where('nama_lengkap', 'like', "%{$search}%");
                });
            })
            ->latest()
            ->paginate($perPage);

        return view('pages.setoran.index', compact('setorans', 'perPage'));
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
                    'status' => $request->has('is_terlambat') ? 'terlambat' : 'normal',
                ]);

                $jenisSampah->increment('stok', $item['jumlah']);

                if (!$request->has('is_terlambat')) {
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
            $siswa->increment('saldo', $totalHargaKeseluruhan);
        });

        return redirect()->route('setoran.index')->with('success', 'Setoran berhasil ditambahkan.');
    }

    public function export()
    {
        return Excel::download(new SetoranExport, 'setoran.xlsx');
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
    // Mengambil daftar kelas dan diurutkan berdasarkan nama
    $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();

    // Mengambil semua jenis sampah yang aktif dan diurutkan
    $allJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah', 'asc')->get();

    // Memisahkan jenis sampah untuk siswa
    $jenisSampahSiswa = $allJenisSampah->filter(function ($value) {
        return strpos(strtolower($value->nama_sampah), 'guru') === false;
    });

    // Memisahkan jenis sampah untuk guru
    $jenisSampahGuru = $allJenisSampah->filter(function ($value) {
        return strpos(strtolower($value->nama_sampah), 'guru') !== false;
    });
    
    // Mengambil ID kelas yang dipilih dari URL
    $selectedKelasId = request('kelas_id');
    $siswa = [];

    // Jika ada kelas yang dipilih, ambil data siswanya
    if ($selectedKelasId) {
        // Ambil data siswa dan URUTKAN berdasarkan nama (A-Z)
        $siswa = Siswa::where('kelas_id', $selectedKelasId)
                      ->orderBy('nama_siswa', 'asc')
                      ->get();
    }

    // Kirim semua data yang dibutuhkan ke view
    return view('pages.setoran.create-massal', compact(
        'kelasList',
        'jenisSampahSiswa',
        'jenisSampahGuru',
        'siswa',
        'selectedKelasId'
    ));
}

    public function storeMassal(Request $request)
    {
        $request->validate([
            'setoran' => 'required|array',
            'setoran.*.*' => 'nullable|numeric|min:0',
            'terlambat' => 'nullable|array',
            'terlambat.*' => 'integer|exists:siswa,id',
            'tanpa_wali_kelas' => 'nullable|array',
            'tanpa_wali_kelas.*' => 'integer|exists:siswa,id'
        ]);

        DB::transaction(function () use ($request) {
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            foreach ($request->setoran as $siswa_id => $sampahData) {
                $totalHargaKeseluruhanSiswa = 0;
                $siswa = Siswa::with('kelas', 'pengguna')->find($siswa_id);

                if (!$siswa) continue;

                $is_terlambat = in_array($siswa_id, $request->terlambat ?? []);
                $tanpa_wali_kelas = in_array($siswa_id, $request->tanpa_wali_kelas ?? []);

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
                            'status' => $is_terlambat ? 'terlambat' : 'normal',
                        ]);

                        $jenisSampah->increment('stok', $jumlah);

                        if (!$is_terlambat && !$tanpa_wali_kelas) {
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
    
    public function editMassal(Request $request)
    {
        $request->validate([
            'setoran_ids' => 'required|array|min:1',
            'setoran_ids.*' => 'exists:setoran,id',
        ],[
            'setoran_ids.required' => 'Pilih setidaknya satu data untuk diedit.'
        ]);
    
        $setoranIds = $request->input('setoran_ids');
        $setorans = Setoran::with(['siswa.pengguna', 'jenisSampah'])->whereIn('id', $setoranIds)->get();
    
        if ($setorans->isEmpty()) {
            return redirect()->route('setoran.index')->with('error', 'Data setoran tidak ditemukan atau tidak ada data yang dipilih.');
        }
    
        $role = $setorans->first()->siswa->pengguna->role ?? 'siswa';
    
        $allJenisSampahs = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah')->get();
    
        if ($role === 'guru') {
            $jenisSampahs = $allJenisSampahs->filter(function ($value) {
                return strpos(strtolower($value->nama_sampah), 'guru') !== false;
            });
        } else {
            $jenisSampahs = $allJenisSampahs->filter(function ($value) {
                return strpos(strtolower($value->nama_sampah), 'guru') === false;
            });
        }
    
        return view('pages.setoran.edit-massal', compact('setorans', 'jenisSampahs', 'setoranIds'));
    }

    public function updateMassal(Request $request)
    {
        $request->validate([
            'setoran_ids' => 'required|array|min:1',
            'setoran_ids.*' => 'exists:setoran,id',
            'jenis_sampah_id' => 'required|exists:jenis_sampah,id',
        ]);

        DB::transaction(function () use ($request) {
            $setoranIds = $request->input('setoran_ids');
            $newJenisSampahId = $request->input('jenis_sampah_id');
            $jenisSampahBaru = JenisSampah::find($newJenisSampahId);

            $setorans = Setoran::with('jenisSampah', 'siswa.pengguna', 'siswa.kelas')->whereIn('id', $setoranIds)->get();
            
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            foreach ($setorans as $setoran) {
                $siswa = $setoran->siswa;
                $jenisSampahLama = $setoran->jenisSampah;
                
                if ($jenisSampahLama && $jenisSampahLama->id == $jenisSampahBaru->id) {
                    continue;
                }

                $siswa->decrement('saldo', $setoran->total_harga);

                if ($jenisSampahLama) {
                    $jenisSampahLama->decrement('stok', $setoran->jumlah);
                }
                $jenisSampahBaru->increment('stok', $setoran->jumlah);
                
                $totalHargaBaru = $setoran->jumlah * $jenisSampahBaru->harga_per_satuan;

                $setoran->update([
                    'jenis_sampah_id' => $newJenisSampahId,
                    'total_harga' => $totalHargaBaru,
                ]);

                $siswa->increment('saldo', $totalHargaBaru);

                Insentif::where('setoran_id', $setoran->id)->delete();
                
                if ($setoran->status !== 'terlambat') {
                    if ($persentaseWaliKelas > 0 && $siswa->kelas && $siswa->kelas->id_wali_kelas) {
                        $insentifWaliKelasBaru = $totalHargaBaru * ($persentaseWaliKelas / 100);

                        if ($insentifWaliKelasBaru > 0) {
                            Insentif::create([
                                'setoran_id' => $setoran->id,
                                'kelas_id' => $siswa->id_kelas,
                                'jumlah_insentif' => $insentifWaliKelasBaru,
                            ]);
                        }
                    }
                }
            }
        });

        return redirect()->route('setoran.index')->with('success', 'Data setoran berhasil diperbarui secara massal.');
    }
}