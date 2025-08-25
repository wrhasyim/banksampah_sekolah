<?php

namespace App\Http\Controllers; // <-- INI BAGIAN YANG DIPERBAIKI

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
        $penjualan->load('detailPenjualan.jenisSampah', 'admin');
        return view('pages.penjualan.show', compact('penjualan'));
    }
}