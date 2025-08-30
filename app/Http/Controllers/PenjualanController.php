<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Penjualan;
use App\Models\Setting;
use App\Models\BukuKas;
use App\Models\Setoran;
use App\Models\Kelas;
use App\Models\Insentif;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PenjualanController extends Controller
{
    public function index()
    {
        $penjualan = Penjualan::with('admin')->latest('tanggal_penjualan')->get();
        return view('pages.penjualan.index', compact('penjualan'));
    }

    public function create()
    {
        $jenisSampah = JenisSampah::where('stok', '>', 0)->get();
        return view('pages.penjualan.create', compact('jenisSampah'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_pengepul' => 'required|string|max:255',
            'items' => 'required|array|min:1',
            'items.*.id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'items.*.jumlah' => 'required|numeric|min:0.01',
            'items.*.subtotal_harga' => 'required|numeric|min:0',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $totalHarga = 0;

                $penjualan = Penjualan::create([
                    'id_admin' => Auth::id(),
                    'nama_pengepul' => $request->nama_pengepul,
                    'tanggal_penjualan' => now(),
                    'total_harga' => 0,
                ]);

                foreach ($request->items as $item) {
                    $jenisSampah = JenisSampah::findOrFail($item['id_jenis_sampah']);

                    if ($jenisSampah->stok < $item['jumlah']) {
                        throw ValidationException::withMessages([
                            'items' => 'Stok untuk ' . $jenisSampah->nama_sampah . ' tidak mencukupi. Sisa stok: ' . $jenisSampah->stok . ' ' . $jenisSampah->satuan,
                        ]);
                    }

                    $totalHarga += $item['subtotal_harga'];

                    $penjualan->detailPenjualan()->create([
                        'id_jenis_sampah' => $item['id_jenis_sampah'],
                        'jumlah' => $item['jumlah'],
                        'subtotal_harga' => $item['subtotal_harga'],
                    ]);

                    $jenisSampah->decrement('stok', $item['jumlah']);
                }

                $penjualan->update(['total_harga' => $totalHarga]);

                // --- LOGIKA BARU: PENCATATAN PEMASUKAN DAN INSENTIF ---

                // 1. Catat total penjualan sebagai PEMASUKAN di Buku Kas
                BukuKas::create([
                    'tanggal' => now(),
                    'deskripsi' => 'Hasil Penjualan ke Pengepul: ' . $request->nama_pengepul . ' (ID: ' . $penjualan->id . ')',
                    'tipe' => 'pemasukan',
                    'jumlah' => $totalHarga,
                    'id_admin' => Auth::id(),
                ]);

                // 2. Ambil persentase honor dari settings
                $settings = Setting::pluck('value', 'key');
                $persentasePengelola = $settings['persentase_pengelola'] ?? 0;
                $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;
                $persentaseSekolah = $settings['persentase_sekolah'] ?? 0;

                // 3. Hitung dan catat honor untuk Pengelola (tetap)
                $honorPengelola = $totalHarga * ($persentasePengelola / 100);
                if ($honorPengelola > 0) {
                    BukuKas::create([
                        'tanggal' => now(),
                        'deskripsi' => 'Honor Pengelola dari Penjualan #' . $penjualan->id,
                        'tipe' => 'pengeluaran',
                        'jumlah' => $honorPengelola,
                        'id_admin' => Auth::id(),
                    ]);
                }

                // 4. Hitung dan catat honor untuk Sekolah (tetap)
                $honorSekolah = $totalHarga * ($persentaseSekolah / 100);
                if ($honorSekolah > 0) {
                    BukuKas::create([
                        'tanggal' => now(),
                        'deskripsi' => 'Honor Sekolah dari Penjualan #' . $penjualan->id,
                        'tipe' => 'pengeluaran',
                        'jumlah' => $honorSekolah,
                        'id_admin' => Auth::id(),
                    ]);
                }

                // 5. Logika Baru: Bagikan honor Wali Kelas secara proporsional
                $totalHonorWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);
                if ($totalHonorWaliKelas > 0) {
                    
                    // Hitung total setoran dari setiap kelas
                    $setoranPerKelas = Setoran::select(
                            'siswa.id_kelas', 
                            DB::raw('SUM(setoran.total_harga) as total_setoran')
                        )
                        ->join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
                        ->groupBy('siswa.id_kelas')
                        ->pluck('total_setoran', 'id_kelas');

                    $totalSemuaSetoran = $setoranPerKelas->sum();

                    if ($totalSemuaSetoran > 0) {
                        foreach ($setoranPerKelas as $kelasId => $totalSetoranKelas) {
                            // Hitung porsi insentif untuk kelas ini
                            $proporsi = $totalSetoranKelas / $totalSemuaSetoran;
                            $insentifKelas = $totalHonorWaliKelas * $proporsi;

                            if ($insentifKelas > 0) {
                                // Catat ke tabel riwayat insentif
                                Insentif::create([
                                    'penjualan_id' => $penjualan->id,
                                    'kelas_id' => $kelasId,
                                    'jumlah_insentif' => $insentifKelas,
                                ]);

                                // Catat sebagai pengeluaran di Buku Kas
                                $kelas = Kelas::find($kelasId);
                                BukuKas::create([
                                    'tanggal' => now(),
                                    'deskripsi' => 'Insentif Wali Kelas: ' . ($kelas->nama_kelas ?? 'Kelas Dihapus') . ' (dari Penjualan #' . $penjualan->id . ')',
                                    'tipe' => 'pengeluaran',
                                    'jumlah' => $insentifKelas,
                                    'id_admin' => Auth::id(),
                                ]);
                            }
                        }
                    }
                }

            });
        } catch (ValidationException $e) {
            return redirect()->back()->withErrors($e->errors())->withInput();
        } catch (\Exception $e) {
            return redirect()->back()->with('toastr-error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penjualan.index')->with('toastr-success', 'Transaksi penjualan berhasil disimpan dan insentif telah dibagikan!');
    }
    
    public function show(Penjualan $penjualan)
    {
        $penjualan->load('detailPenjualan.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}