<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Penjualan;
use App\Models\DetailPenjualan;
use App\Models\JenisSampah;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use App\Models\Setting;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class PenjualanController extends Controller
{
    public function index()
    {
        $penjualan = Penjualan::latest()->paginate(10);
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
            'tanggal_penjualan' => 'required|date',
            'nama_pengepul' => 'required|string|max:255',
            'sampah' => 'required|array|min:1',
            'sampah.*.id' => 'required|exists:jenis_sampah,id',
            'sampah.*.jumlah' => 'required|numeric|min:0.01',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $totalPenjualan = 0;

                foreach ($request->sampah as $item) {
                    $jenisSampah = JenisSampah::find($item['id']);
                    if ($item['jumlah'] > $jenisSampah->stok) {
                        throw new \Exception('Stok untuk ' . $jenisSampah->nama_sampah . ' tidak mencukupi.');
                    }
                    $totalPenjualan += $item['jumlah'] * $jenisSampah->harga_jual;
                }

                $penjualan = Penjualan::create([
                    'tanggal_penjualan' => $request->tanggal_penjualan,
                    'nama_pengepul' => $request->nama_pengepul,
                    'total_harga' => $totalPenjualan,
                    'id_admin' => Auth::id(),
                ]);

                foreach ($request->sampah as $item) {
                    $jenisSampah = JenisSampah::find($item['id']);
                    DetailPenjualan::create([
                        'id_penjualan' => $penjualan->id,
                        'id_jenis_sampah' => $item['id'],
                        'jumlah' => $item['jumlah'],
                        'subtotal_harga' => $item['jumlah'] * $jenisSampah->harga_jual,
                    ]);
                    $jenisSampah->decrement('stok', $item['jumlah']);
                }

                $kategoriPemasukan = KategoriTransaksi::firstOrCreate(
                    ['nama_kategori' => 'Hasil Penjualan Sampah'],
                    ['tipe' => 'pemasukan']
                );
                BukuKas::create([
                    'tanggal' => $request->tanggal_penjualan,
                    'deskripsi' => 'Hasil Penjualan Sampah ke ' . $request->nama_pengepul . ' (Inv: #' . $penjualan->id . ')',
                    'tipe' => 'pemasukan',
                    'jumlah' => $totalPenjualan,
                    'id_admin' => Auth::id(),
                    'id_kategori' => $kategoriPemasukan->id,
                ]);

                // =================== PERBAIKAN LOGIKA DI SINI ===================
                // Mengambil nilai persentase honor secara spesifik dari database
                $settingHonor = Setting::where('key', 'persentase_honor')->first();
                $persentaseHonor = $settingHonor ? (float)$settingHonor->value : 0;
                // ================================================================

                if ($persentaseHonor > 0) {
                    $jumlahHonor = $totalPenjualan * ($persentaseHonor / 100);

                    if ($jumlahHonor > 0) {
                        $kategoriPengeluaran = KategoriTransaksi::firstOrCreate(
                            ['nama_kategori' => 'Honor Penjualan'],
                            ['tipe' => 'pengeluaran']
                        );
                        BukuKas::create([
                            'tanggal' => $request->tanggal_penjualan,
                            'deskripsi' => 'Honor ' . $persentaseHonor . '% dari Penjualan (Inv: #' . $penjualan->id . ')',
                            'tipe' => 'pengeluaran',
                            'jumlah' => $jumlahHonor,
                            'id_admin' => Auth::id(),
                            'id_kategori' => $kategoriPengeluaran->id,
                        ]);
                    }
                }
            });

        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Gagal menyimpan penjualan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penjualan.index')->with('success', 'Data penjualan berhasil disimpan dan dicatat di Buku Kas.');
    }

    public function show(Penjualan $penjualan)
    {
        $penjualan->load('detailPenjualans.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}