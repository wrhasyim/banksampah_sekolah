<?php

namespace App\Http\Controllers;

use App\Models\Reward;
use App\Models\Pengguna;
use App\Models\JenisSampah;
use App\Models\BukuKas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class RewardController extends Controller
{
    /**
     * Menampilkan daftar semua reward.
     */
    public function index()
    {
        $rewards = Reward::with('pengguna')->latest()->paginate(10);
        return view('pages.rewards.index', compact('rewards'));
    }

    /**
     * Menampilkan form untuk membuat reward baru.
     */
    public function create()
    {
        $siswas = Pengguna::where('role', 'siswa')->orderBy('nama_lengkap')->get();

        // Mengambil harga botol untuk kalkulator otomatis di view
        $jenisSampah = JenisSampah::where('nama_sampah', 'Botol Plastik')->first();
        $hargaPerBotol = $jenisSampah ? $jenisSampah->harga_per_satuan : 0;
        
        return view('pages.rewards.create', compact('siswas', 'hargaPerBotol'));
    }

    /**
     * Menyimpan reward baru, menambahkan ke tabungan, dan mencatat biaya operasional.
     */
    public function store(Request $request)
    {
        // Validasi input dari form
        $validated = $request->validate([
            'user_id' => 'required|exists:pengguna,id',
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string',
        ]);

        // Mengambil data harga dari Jenis Sampah
        $jenisSampah = JenisSampah::where('nama_sampah', 'Botol Plastik')->firstOrFail();
        $pricePerItem = $jenisSampah->harga_per_satuan;
        $totalCost = $validated['quantity'] * $pricePerItem;

        // Menggunakan transaction untuk memastikan semua proses berjalan atau tidak sama sekali
        DB::transaction(function () use ($validated, $pricePerItem, $totalCost) {
            
            $pengguna = Pengguna::find($validated['user_id']);

            // 1. Catat pemberian reward di tabel 'rewards'
            Reward::create([
                'user_id' => $validated['user_id'],
                'quantity' => $validated['quantity'],
                'description' => $validated['description'],
                'item_name' => 'botol',
                'price_per_item_at_reward' => $pricePerItem,
                'total_operational_cost' => $totalCost,
            ]);

            // 2. Tambahkan ke saldo siswa dengan sumber 'reward' (tidak masuk leaderboard)
            if ($pengguna && $pengguna->siswa) {
                $pengguna->siswa->setoran()->create([
                    'sumber' => 'reward', 
                    'kredit' => $totalCost,
                    'keterangan' => 'Pemasukan dari Reward: ' . ($validated['description'] ?? $validated['quantity'] . ' botol'),
                ]);
            }

            // 3. Catat sebagai 'pengeluaran' di Buku Kas
            $keteranganReward = 'Biaya Operasional: Reward untuk ' . $pengguna->nama_lengkap;
            
            BukuKas::create([
                'tipe' => 'pengeluaran',
                'tanggal' => now(),
                'deskripsi' => $keteranganReward,
                'jumlah' => $totalCost,
                'debit' => $totalCost,
                'keterangan' => $keteranganReward,
                'id_admin' => Auth::id(),
            ]);
        });

        return redirect()->route('rewards.index')->with('toastr-success', 'Reward berhasil diberikan, saldo siswa bertambah, dan biaya tercatat!');
    }
}