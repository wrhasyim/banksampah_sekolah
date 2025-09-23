<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\JenisSampah;
use Illuminate\Support\Facades\DB;

class StokMasukController extends Controller
{
    /**
     * Menampilkan form untuk menambah stok.
     */
    public function create(Request $request)
    {
        // Ambil data jenis sampah yang dipilih dari tombol di halaman index
        $jenisSampah = JenisSampah::find($request->jenis_sampah_id);

        if (!$jenisSampah) {
            // Jika tidak ada ID, tampilkan semua jenis sampah
            $semuaJenisSampah = JenisSampah::where('status', 'aktif')->orderBy('nama_sampah')->get();
            return view('pages.stok.create', compact('semuaJenisSampah'));
        }

        return view('pages.stok.create', compact('jenisSampah'));
    }

    /**
     * Menyimpan data penambahan stok ke database.
     */
    public function store(Request $request)
    {
        $request->validate([
            'jenis_sampah_id' => 'required|exists:jenis_sampah,id',
            'jumlah' => 'required|numeric|min:0.01',
            // Anda bisa menambahkan validasi untuk 'keterangan' jika perlu
        ]);

        try {
            DB::beginTransaction();

            $jenisSampah = JenisSampah::findOrFail($request->jenis_sampah_id);

            // Tambahkan stok ke jenis sampah terkait
            $jenisSampah->increment('stok', $request->jumlah);
            
            // Di sini Anda bisa menambahkan pencatatan ke tabel log/histori jika ada
            // Misalnya: StokLog::create([...]);

            DB::commit();

            return redirect()->route('jenis-sampah.index')->with('success', 'Stok untuk ' . $jenisSampah->nama_sampah . ' berhasil ditambahkan!');

        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }
    }
}