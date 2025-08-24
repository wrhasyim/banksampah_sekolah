<?php

namespace App\Http\Controllers;

use App\Models\JenisSampah;
use App\Models\Penjualan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PenjualanController extends Controller
{
    public function index()
    {
        $penjualan = Penjualan::with('admin')->latest()->get();
        return view('pages.penjualan.index', compact('penjualan'));
    }

    public function create()
    {
        // Ambil hanya sampah yang memiliki stok
        $jenisSampah = JenisSampah::where('stok', '>', 0)->get();
        return view('pages.penjualan.create', compact('jenisSampah'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_pengepul' => 'required|string|max:255',
            'items' => 'required|array|min:1',
            'items.*.id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'items.*.jumlah' => 'required|numeric|min:1',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $totalHarga = 0;

                // Buat record penjualan utama
                $penjualan = Penjualan::create([
                    'id_admin' => Auth::id(),
                    'nama_pengepul' => $request->nama_pengepul,
                    'total_harga' => 0, // Akan diupdate nanti
                ]);

                foreach ($request->items as $item) {
                    $jenisSampah = JenisSampah::findOrFail($item['id_jenis_sampah']);

                    // Validasi apakah stok mencukupi
                    if ($jenisSampah->stok < $item['jumlah']) {
                        throw ValidationException::withMessages([
                            'items' => 'Stok untuk ' . $jenisSampah->nama_sampah . ' tidak mencukupi. Sisa stok: ' . $jenisSampah->stok,
                        ]);
                    }

                    $subtotal = $jenisSampah->harga_per_satuan * $item['jumlah'];
                    $totalHarga += $subtotal;

                    // Buat record detail penjualan
                    $penjualan->detailPenjualan()->create([
                        'id_jenis_sampah' => $item['id_jenis_sampah'],
                        'jumlah_satuan' => $item['jumlah'],
                        'subtotal_harga' => $subtotal,
                    ]);

                    // Kurangi stok sampah
                    $jenisSampah->decrement('stok', $item['jumlah']);
                }

                // Update total harga di record penjualan utama
                $penjualan->update(['total_harga' => $totalHarga]);
            });
        } catch (ValidationException $e) {
            return redirect()->back()->withErrors($e->errors())->withInput();
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penjualan.index')->with('status', 'Transaksi penjualan berhasil disimpan!');
    }
    
    public function show(Penjualan $penjualan)
    {
        // Muat relasi detail dan jenis sampahnya untuk ditampilkan
        $penjualan->load('detailPenjualan.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}