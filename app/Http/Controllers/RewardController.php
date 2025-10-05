<?php

namespace App\Http\Controllers;

use App\Models\Reward;
use App\Models\Siswa;
use App\Models\Pengguna; // Pastikan model Pengguna di-import
use App\Models\Setting;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class RewardController extends Controller
{
    /**
     * Menampilkan riwayat pemberian reward.
     */
    public function index()
    {
        // Sesuaikan relasi dari 'siswa' menjadi 'pengguna'
        $rewards = Reward::with('pengguna')->latest()->paginate(10);
        return view('pages.rewards.index', compact('rewards'));
    }

    /**
     * Menampilkan formulir untuk memberikan reward.
     */
    public function create()
    {
        $hargaPerBotol = Setting::where('key', 'harga_per_botol')->value('value') ?? 0;
        return view('pages.rewards.create', compact('hargaPerBotol'));
    }

    /**
     * Menyimpan data reward baru.
     */
    public function store(Request $request)
    {
        // Validasi input dari form
        $request->validate([
            'user_id' => 'required|exists:pengguna,id', // Validasi ke tabel 'pengguna'
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string|max:255',
        ]);

        DB::beginTransaction();
        try {
            // Ambil harga per botol dari settings
            $hargaPerBotol = Setting::where('key', 'harga_per_botol')->value('value') ?? 0;
            if ($hargaPerBotol <= 0) {
                throw new \Exception('Harga per botol belum diatur di menu Settings.');
            }

            $jumlahBotol = $request->quantity;
            $totalBiaya = $jumlahBotol * $hargaPerBotol;
            
            // Cari data siswa berdasarkan user_id (id_pengguna) yang dipilih
            $siswa = Siswa::where('id_pengguna', $request->user_id)->first();
            if (!$siswa) {
                throw new \Exception('Data siswa tidak ditemukan untuk pengguna yang dipilih.');
            }

            // 1. Tambahkan total biaya ke saldo siswa
            $siswa->increment('saldo', $totalBiaya);

            // 2. Simpan data reward sesuai struktur tabel yang benar
            Reward::create([
                'user_id' => $request->user_id,
                'quantity' => $jumlahBotol,
                'item_name' => 'Botol Plastik', // Item diasumsikan 'Botol Plastik'
                'description' => $request->description,
                'price_per_item_at_reward' => $hargaPerBotol,
                'total_operational_cost' => $totalBiaya,
            ]);

            // 3. Catat sebagai biaya operasional di Buku Kas
            $pengguna = Pengguna::find($request->user_id);
            $kategori = KategoriTransaksi::where('nama_kategori', 'Biaya Operasional')->first();
            if (!$kategori) {
                throw new \Exception('Kategori transaksi "Biaya Operasional" tidak ditemukan.');
            }

            $deskripsiBukuKas = "Biaya Reward ({$jumlahBotol} botol) untuk " . trim($pengguna->nama_lengkap);

            BukuKas::create([
                'id_kategori' => $kategori->id,
                'deskripsi' => $deskripsiBukuKas,
                'tipe' => 'keluar',
                'jumlah' => $totalBiaya,
                'tanggal' => now(),
                'id_admin' => Auth::id(),
            ]);

            DB::commit(); // Konfirmasi semua transaksi jika berhasil
            return redirect()->route('rewards.index')->with('success', 'Reward berhasil diberikan dan saldo siswa telah ditambahkan.');

        } catch (\Throwable $e) {
            DB::rollBack(); // Batalkan semua jika ada error
            Log::error("Gagal memberi reward: " . $e->getMessage());
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }
    }
}