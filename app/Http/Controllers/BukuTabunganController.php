<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use Illuminate\Support\Facades\Auth;

class BukuTabunganController extends Controller
{
    /**
     * Menampilkan halaman buku tabungan berdasarkan role pengguna.
     */
    public function index(Request $request)
    {
        $user = Auth::user();

        // --- PERBAIKAN: Mengganti hasRole() dengan pengecekan kolom 'role' ---
        if ($user->role === 'admin') {
            $query = $request->input('query');
            $results = null;

            if ($query) {
                $results = Siswa::whereHas('pengguna', function($q) use ($query) {
                    $q->where('nama_lengkap', 'like', "%$query%");
                })->get();
            }

            return view('pages.buku-tabungan.index', compact('results', 'query'));
        }

        // Jika user adalah siswa
        $siswa = Siswa::where('id_pengguna', $user->id)->firstOrFail();

        $setorans = Setoran::where('siswa_id', $siswa->id)->get();
        $penarikans = Penarikan::where('siswa_id', $siswa->id)->where('status', 'disetujui')->get();

        $transaksi = $setorans->map(function ($setoran) {
            return (object) [
                'tanggal' => $setoran->created_at,
                'deskripsi' => 'Setoran Sampah (' . ($setoran->jenisSampah->nama_sampah ?? 'N/A') . ')',
                'kredit' => $setoran->total_harga,
                'debit' => 0,
            ];
        })->concat($penarikans->map(function ($penarikan) {
            return (object) [
                'tanggal' => $penarikan->created_at,
                'deskripsi' => 'Penarikan Saldo',
                'kredit' => 0,
                'debit' => $penarikan->jumlah_penarikan,
            ];
        }));

        $transaksi = $transaksi->sortByDesc('tanggal');

        return view('pages.buku-tabungan.index', compact('siswa', 'transaksi'));
    }

    /**
     * Menampilkan detail tabungan seorang siswa (untuk admin).
     */
    public function show(Siswa $siswa)
    {
        // --- PERBAIKAN: Mengganti hasRole() dengan pengecekan kolom 'role' ---
        if (Auth::user()->role !== 'admin') {
            abort(403, 'ANDA TIDAK MEMILIKI AKSES.');
        }

        $setorans = Setoran::where('siswa_id', $siswa->id)->get();
        $penarikans = Penarikan::where('siswa_id', $siswa->id)->where('status', 'disetujui')->get();

        $transaksi = $setorans->map(function ($setoran) {
            return (object) [
                'tanggal' => $setoran->created_at,
                'deskripsi' => 'Setoran Sampah (' . ($setoran->jenisSampah->nama_sampah ?? 'N/A') . ')',
                'kredit' => $setoran->total_harga,
                'debit' => 0,
            ];
        })->concat($penarikans->map(function ($penarikan) {
            return (object) [
                'tanggal' => $penarikan->created_at,
                'deskripsi' => 'Penarikan Saldo',
                'kredit' => 0,
                'debit' => $penarikan->jumlah_penarikan,
            ];
        }));
        
        $transaksi = $transaksi->sortByDesc('tanggal');
        
        return view('pages.buku-tabungan.index', compact('siswa', 'transaksi'));
    }
}