<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Penjualan;
use App\Models\DetailPenjualan;
use App\Models\JenisSampah;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
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
                    
                    // --- PERBAIKAN UTAMA DI SINI ---
                    DetailPenjualan::create([
                        // Menggunakan 'id_penjualan' sesuai Model Anda
                        'id_penjualan' => $penjualan->id, 
                        // Menggunakan 'id_jenis_sampah' sesuai Model Anda
                        'id_jenis_sampah' => $item['id'], 
                        'jumlah' => $item['jumlah'],
                        // Menggunakan 'subtotal_harga' sesuai Model Anda
                        'subtotal_harga' => $item['jumlah'] * $jenisSampah->harga_jual, 
                    ]);

                    $jenisSampah->decrement('stok', $item['jumlah']);
                }

                $kategori = KategoriTransaksi::firstOrCreate(
                    ['nama_kategori' => 'Hasil Penjualan Sampah'],
                    ['tipe' => 'pemasukan']
                );

                BukuKas::create([
                    'tanggal' => $request->tanggal_penjualan,
                    'deskripsi' => 'Hasil Penjualan Sampah ke ' . $request->nama_pengepul,
                    'tipe' => 'pemasukan',
                    'jumlah' => $totalPenjualan,
                    'id_admin' => Auth::id(),
                    'id_kategori' => $kategori->id,
                ]);
            });

        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Gagal menyimpan penjualan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penjualan.index')->with('success', 'Data penjualan berhasil disimpan.');
    }

    public function show(Penjualan $penjualan)
    {
        $penjualan->load('detailPenjualans.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}