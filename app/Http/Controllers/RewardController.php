<?php

namespace App\Http\Controllers;

use App\Models\Reward;
use App\Models\Pengguna;
use App\Models\JenisSampah; // Model yang benar
use Illuminate\Http\Request;

class RewardController extends Controller
{
    public function index()
    {
        $rewards = Reward::with('pengguna')->latest()->paginate(10);
        return view('pages.rewards.index', compact('rewards'));
    }

    public function create()
    {
        $siswas = Pengguna::where('role', 'siswa')->orderBy('nama_lengkap')->get();
        return view('pages.rewards.create', compact('siswas'));
    }

    public function store(Request $request)
    {
        // 1. Validasi input
        $validated = $request->validate([
            'user_id' => 'required|exists:pengguna,id',
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string',
        ]);

        // 2. Ambil harga dari model JenisSampah dengan kolom yang benar
        // Sesuaikan 'Botol Plastik' dengan nama sampah di database Anda
        $jenisSampah = JenisSampah::where('nama_sampah', 'Botol Plastik')->firstOrFail();
        $pricePerItem = $jenisSampah->harga_per_satuan; // <-- KOLOM DIPERBAIKI

        // 3. Kalkulasi total biaya operasional
        $totalCost = $validated['quantity'] * $pricePerItem;

        // 4. Simpan data ke database
        Reward::create([
            'user_id' => $validated['user_id'],
            'quantity' => $validated['quantity'],
            'description' => $validated['description'],
            'item_name' => 'botol',
            'price_per_item_at_reward' => $pricePerItem,
            'total_operational_cost' => $totalCost,
        ]);

        return redirect()->route('rewards.index')->with('toastr-success', 'Reward berhasil diberikan!');
    }
}