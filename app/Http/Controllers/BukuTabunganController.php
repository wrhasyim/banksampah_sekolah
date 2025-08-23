<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BukuTabunganController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        // Pastikan user adalah siswa dan punya data siswa
        if ($user->role !== 'siswa' || !$user->siswa) {
            abort(403, 'Akses Ditolak.');
        }

        $siswa = $user->siswa;

        // Ambil semua data setoran dan format
        $setoran = $siswa->setoran()->with('jenisSampah')->get()->map(function ($item) {
            return (object) [
                'tanggal' => $item->created_at,
                'deskripsi' => 'Setoran: ' . $item->jenisSampah->nama_sampah . ' (' . $item->jumlah_satuan . ' pcs)',
                'kredit' => $item->total_harga,
                'debit' => 0,
            ];
        });

        // Ambil semua data penarikan dan format
        $penarikan = $siswa->penarikan()->get()->map(function ($item) {
            return (object) [
                'tanggal' => $item->created_at,
                'deskripsi' => 'Penarikan Saldo',
                'kredit' => 0,
                'debit' => $item->jumlah_penarikan,
            ];
        });

        // Gabungkan kedua koleksi data dan urutkan berdasarkan tanggal
        $transaksi = $setoran->concat($penarikan)->sortByDesc('tanggal');

        return view('pages.buku-tabungan.index', compact('siswa', 'transaksi'));
    }
}