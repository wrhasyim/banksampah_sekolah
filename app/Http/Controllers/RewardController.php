<?php

namespace App\Http\Controllers;

use App\Models\Reward;
use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\JenisSampah; // DIUBAH: Kembali menggunakan JenisSampah
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
        $rewards = Reward::with('pengguna')->latest()->paginate(10);
        return view('pages.rewards.index', compact('rewards'));
    }

    /**
     * Menampilkan formulir untuk memberikan reward.
     */
    public function create()
    {
        $siswas = Pengguna::where('role', 'siswa')->orderBy('nama_lengkap')->get();

        // PERBAIKAN: Mengambil harga dari tabel jenis_sampah
        $jenisSampah = JenisSampah::where('nama_sampah', 'Botol Plastik')->first();
        $hargaPerSatuan = $jenisSampah ? $jenisSampah->harga_per_satuan : 0;
        
        // Kirimkan variabel $siswas dan $hargaPerSatuan ke view
        return view('pages.rewards.create', compact('siswas', 'hargaPerSatuan'));
    }

    /**
     * Menyimpan data reward baru.
     */
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:pengguna,id',
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string|max:255',
        ]);

        DB::beginTransaction();
        try {
            // PERBAIKAN: Mengambil harga dari tabel jenis_sampah
            $jenisSampah = JenisSampah::where('nama_sampah', 'Botol Plastik')->first();
            if (!$jenisSampah || $jenisSampah->harga_per_satuan <= 0) {
                throw new \Exception('Harga untuk "Botol Plastik" belum diatur di menu Jenis Sampah.');
            }
            $hargaPerSatuan = $jenisSampah->harga_per_satuan;

            $jumlahBotol = $request->quantity;
            $totalBiaya = $jumlahBotol * $hargaPerSatuan;
            
            $siswa = Siswa::where('id_pengguna', $request->user_id)->first();
            if (!$siswa) {
                throw new \Exception('Data siswa tidak ditemukan untuk pengguna yang dipilih.');
            }

            // 1. Tambahkan total biaya ke saldo siswa
            $siswa->increment('saldo', $totalBiaya);

            // 2. Simpan data reward
            Reward::create([
                'user_id' => $request->user_id,
                'quantity' => $jumlahBotol,
                'item_name' => 'Botol Plastik',
                'description' => $request->description,
                'price_per_item_at_reward' => $hargaPerSatuan,
                'total_operational_cost' => $totalBiaya,
            ]);

            // 3. Catat sebagai biaya operasional di Buku Kas
            $pengguna = Pengguna::find($request->user_id);
            $kategori = KategoriTransaksi::where('nama_kategori', 'Biaya Operasional')->firstOrFail();
            $deskripsiBukuKas = "Biaya Reward ({$jumlahBotol} botol) untuk " . trim($pengguna->nama_lengkap);

            BukuKas::create([
                'id_kategori' => $kategori->id,
                'deskripsi' => $deskripsiBukuKas,
                'tipe' => 'keluar',
                'jumlah' => $totalBiaya,
                'tanggal' => now(),
                'id_admin' => Auth::id(),
            ]);

            DB::commit();
            return redirect()->route('rewards.index')->with('success', 'Reward berhasil diberikan dan saldo siswa telah ditambahkan.');

        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error("Gagal memberi reward: " . $e->getMessage());
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }
    }
}