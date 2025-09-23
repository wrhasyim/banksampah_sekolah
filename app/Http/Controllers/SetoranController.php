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
    /**
     * Menampilkan daftar setoran dengan fungsionalitas filter dan pencarian.
     */
    public function index(Request $request)
    {
        $perPage = $request->input('perPage', 10);
        $search = $request->input('search');
        $kelasId = $request->input('kelas_id');
        $tanggalMulai = $request->input('tanggal_mulai');
        $tanggalSelesai = $request->input('tanggal_selesai');

        $setorans = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->when($search, function ($query, $search) {
                $query->whereHas('siswa.pengguna', function ($q) use ($search) {
                    $q->where('nama_lengkap', 'like', "%{$search}%");
                });
            })
            ->when($kelasId, function ($query, $kelasId) {
                $query->whereHas('siswa', function ($q) use ($kelasId) {
                    $q->where('id_kelas', $kelasId);
                });
            })
            ->when($tanggalMulai, function ($query, $tanggalMulai) {
                $query->whereDate('created_at', '>=', $tanggalMulai);
            })
            ->when($tanggalSelesai, function ($query, $tanggalSelesai) {
                $query->whereDate('created_at', '<=', $tanggalSelesai);
            })
            ->latest()
            ->paginate($perPage);

        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();

        return view('pages.setoran.index', compact('setorans', 'perPage', 'kelasList'));
    }

    /**
     * Menampilkan form untuk membuat setoran baru.
     */
    public function create()
    {
        $jenisSampah = JenisSampah::where('status', 'aktif')
                                ->where('kategori', 'Siswa')
                                ->orderBy('nama_sampah', 'asc')
                                ->get();
        $siswa = Siswa::with('kelas')->get();
        return view('pages.setoran.create', compact('jenisSampah', 'siswa'));
    }

    /**
     * Menyimpan setoran baru ke database.
     */
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
            $siswa = Siswa::with('kelas.waliKelas', 'pengguna')->find($request->siswa_id);

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

                if (!$request->has('is_terlambat')) {
                    if ($persentaseWaliKelas > 0 && optional($siswa->kelas)->id_wali_kelas) {
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

    /**
     * Menampilkan form untuk setoran massal.
     */
    public function createMassal()
    {
        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();
        $allJenisSampah = JenisSampah::where('status', 'aktif')
                                       ->where('kategori', 'Siswa')
                                       ->orderBy('nama_sampah', 'asc')
                                       ->get();

        $jenisSampahSiswa = $allJenisSampah->filter(fn($v) => strpos(strtolower($v->nama_sampah),'guru') === false);
        $jenisSampahGuru = $allJenisSampah->filter(fn($v) => strpos(strtolower($v->nama_sampah),'guru') !== false);
        
        $selectedKelasId = request('kelas_id');
        $siswa = [];
        if ($selectedKelasId) {
            $siswa = Siswa::where('id_kelas', $selectedKelasId)->with('pengguna')->orderBy('nama_siswa', 'asc')->get();
        }
        return view('pages.setoran.create-massal', compact('kelasList','jenisSampahSiswa','jenisSampahGuru','siswa','selectedKelasId'));
    }
    
    /**
     * Menyimpan data dari setoran massal.
     */
    public function storeMassal(Request $request)
    {
        $request->validate([
            'setoran' => 'required|array',
            'setoran.*.*' => 'nullable|numeric|min:0',
        ]);

        DB::transaction(function () use ($request) {
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;
            
            // PERUBAHAN: Cek kedua master checkbox
            $semuaTanpaWaliKelas = $request->has('semua_tanpa_wali_kelas');
            $semuaTerlambat = $request->has('semua_terlambat');

            foreach ($request->setoran as $siswa_id => $sampahData) {
                $totalHargaKeseluruhanSiswa = 0;
                $siswa = Siswa::with('kelas.waliKelas', 'pengguna')->find($siswa_id);

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
                            'status' => $semuaTerlambat ? 'terlambat' : 'normal',
                        ]);
                        
                        // PERUBAHAN: Insentif hanya dihitung jika TIDAK terlambat DAN TIDAK tanpa wali kelas
                        if (!$semuaTerlambat && !$semuaTanpaWaliKelas) {
                            if ($persentaseWaliKelas > 0 && optional($siswa->kelas)->id_wali_kelas) {
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
    
    // ... sisa method tidak berubah ...

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
            return ['id' => $item->id, 'text' => $item->pengguna->nama_lengkap . ' (' . (optional($item->kelas)->nama_kelas ?? 'Tanpa Kelas') . ')'];
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
            return redirect()->route('setoran.index')->with('error', 'Data setoran tidak ditemukan.');
        }
    
        $jenisSampahs = JenisSampah::where('status', 'aktif')
                                    ->where('kategori', 'Siswa')
                                    ->orderBy('nama_sampah', 'asc')
                                    ->get();
    
        return view('pages.setoran.edit-massal', compact('setorans', 'jenisSampahs'));
    }

    public function updateMassal(Request $request)
    {
        $request->validate([
            'setoran' => 'sometimes|array',
            'setoran.*.jumlah' => 'required_with:setoran|numeric|min:0',
            'setoran.*.jenis_sampah_id' => 'required_with:setoran|exists:jenis_sampah,id',
            'hapus' => 'sometimes|array',
        ]);

        DB::transaction(function () use ($request) {
            $settings = Setting::pluck('value', 'key');
            $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;

            if ($request->has('hapus')) {
                $idsToDelete = array_keys($request->hapus);
                $setoransToDelete = Setoran::with('siswa', 'jenisSampah')->findMany($idsToDelete);

                foreach ($setoransToDelete as $setoran) {
                    $setoran->siswa->decrement('saldo', $setoran->total_harga);
                    Insentif::where('setoran_id', $setoran->id)->delete();
                    $setoran->delete();
                }
            }

            if ($request->has('setoran')) {
                foreach ($request->setoran as $id => $data) {
                    if ($request->has('hapus') && isset($request->hapus[$id])) {
                        continue;
                    }

                    $setoran = Setoran::with('siswa.kelas.waliKelas', 'jenisSampah')->find($id);
                    if (!$setoran) continue;

                    $setoran->siswa->decrement('saldo', $setoran->total_harga);
                    Insentif::where('setoran_id', $setoran->id)->delete();

                    $jenisSampahBaru = JenisSampah::find($data['jenis_sampah_id']);
                    $jumlahBaru = (float) $data['jumlah'];
                    $totalHargaBaru = $jumlahBaru * $jenisSampahBaru->harga_per_satuan;

                    $setoran->update([
                        'jenis_sampah_id' => $jenisSampahBaru->id,
                        'jumlah' => $jumlahBaru,
                        'total_harga' => $totalHargaBaru,
                    ]);

                    $setoran->siswa->increment('saldo', $totalHargaBaru);
                    
                    if ($setoran->status !== 'terlambat' && !$request->has('tanpa_wali_kelas.' . $setoran->siswa_id) && optional($setoran->siswa->kelas)->id_wali_kelas) {
                        if ($persentaseWaliKelas > 0 && $totalHargaBaru > 0) {
                            $insentifWaliKelasBaru = $totalHargaBaru * ($persentaseWaliKelas / 100);
                            Insentif::create([
                                'setoran_id' => $setoran->id, 'kelas_id' => $setoran->siswa->id_kelas,
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