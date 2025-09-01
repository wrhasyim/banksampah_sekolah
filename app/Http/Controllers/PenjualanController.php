<?php

namespace App\Http\Controllers;

// ... (use statements) ...
use App\Models\Setting;
use App\Models\BukuKas;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Models\Penjualan;
use App\Models\JenisSampah;
use Illuminate\Http\Request;

class PenjualanController extends Controller
{
    // ... (method index dan create) ...
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
                // ... (logika pembuatan penjualan dan detail penjualan) ...
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
                $persentaseSekolah = $settings['persentase_sekolah'] ?? 0;

                // 3. Hitung dan catat honor untuk Pengelola
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

                // 4. Hitung dan catat honor untuk Sekolah
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

                // 5. HAPUS BAGIAN INI: Logika insentif wali kelas telah dipindahkan
                /*
                $persentaseWaliKelas = $settings['persentase_wali_kelas'] ?? 0;
                $totalHonorWaliKelas = $totalHarga * ($persentaseWaliKelas / 100);
                if ($totalHonorWaliKelas > 0) {
                    // ... (kode lama yang menghitung proporsi) ...
                }
                */

            });
        } catch (ValidationException $e) {
            return redirect()->back()->withErrors($e->errors())->withInput();
        } catch (\Exception $e) {
            return redirect()->back()->with('toastr-error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penjualan.index')->with('toastr-success', 'Transaksi penjualan berhasil disimpan!');
    }
    // ... (method show) ...
    public function show(Penjualan $penjualan)
    {
        $penjualan->load('detailPenjualan.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}