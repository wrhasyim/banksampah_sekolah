<?php

namespace App\Http\Controllers;

use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth; // Pastikan Auth di-import
use Barryvdh\DomPDF\Facade\Pdf;

class BukuTabunganController extends Controller
{
    /**
     * Menampilkan daftar siswa (untuk admin) atau buku tabungan pribadi (untuk siswa).
     */
    public function index(Request $request)
    {
        $user = Auth::user();

        // Tampilan untuk Admin (Daftar Siswa)
        if ($user->role === 'admin') {
            $query = Siswa::query()->with('pengguna', 'kelas');

            if ($request->filled('search')) {
                $search = $request->input('search');
                $query->whereHas('pengguna', function ($q) use ($search) {
                    $q->where('nama_lengkap', 'like', "%{$search}%");
                })->orWhere('nis', 'like', "%{$search}%");
            }

            if ($request->filled('id_kelas')) {
                $query->where('id_kelas', $request->id_kelas);
            }

            $siswas = $query->latest()->paginate(10)->withQueryString();
            // Asumsi view Anda adalah 'pages.buku-tabungan.index'
            // Jika nama file beda, sesuaikan 'pages.buku-tabungan.index-admin'
            return view('pages.buku-tabungan.index', compact('siswas'));
        }

        // Tampilan untuk Siswa (Buku Tabungan Pribadi)
        if ($user->role === 'siswa') {
            $siswa = $user->siswa;
            if (!$siswa) {
                abort(404, 'Data siswa tidak ditemukan.');
            }
            // Panggil logic dari method show()
            return $this->show($siswa);
        }

        // Jika role lain (seperti 'wali') mencoba mengakses index, block
        // Ini ditangani oleh middleware di web.php, tapi sebagai fallback:
        abort(404);
    }

    /**
     * Menampilkan detail buku tabungan untuk satu siswa.
     * (DIPERBARUI UNTUK AKSES WALI KELAS)
     */
    public function show(Siswa $siswa)
    {
        $user = Auth::user();

        // ==================================================
        // --- LOGIKA OTORISASI BARU DIMULAI DI SINI ---
        // ==================================================
        $isOwner = ($user->role === 'siswa' && $user->id === $siswa->id_pengguna);
        $isAdmin = ($user->role === 'admin');
        $isWaliKelas = false;

        if ($user->role === 'wali') {
            $kelasWali = $user->kelasYangDiampu;
            
            // ===================================
            // --- PERBAIKAN ADA DI BARIS INI ---
            // ===================================
            // Cek jika wali punya kelas DAN id kelas siswa = id kelas wali
            // Gunakan '==' (loose comparison) untuk menghindari masalah tipe data (int vs string)
            if ($kelasWali && $kelasWali->id == $siswa->id_kelas) { // <-- PERBAIKAN
                $isWaliKelas = true;
            }
        }

        // Jika BUKAN Admin, BUKAN Pemilik, dan BUKAN Wali Kelasnya, tolak akses
        if (!$isAdmin && !$isOwner && !$isWaliKelas) {
            abort(403, 'AKSES DITOLAK'); // Ini adalah error 403 yang Anda lihat
        }
        // ==================================================
        // --- LOGIKA OTORISASI SELESAI ---
        // ==================================================

        // Mengambil semua setoran dan penarikan
        $setorans = $siswa->setoran()->with('jenisSampah')->latest()->get();
        $penarikans = $siswa->penarikan()->latest()->get();

        // Menggabungkan dan mengurutkan berdasarkan tanggal
        $transaksis = $setorans->map(function ($setoran) {
            return (object) [
                'tanggal' => $setoran->created_at,
                'jenis' => 'setoran',
                'deskripsi' => 'Setoran (' . ($setoran->jenisSampah->nama_sampah ?? 'N/A') . ')',
                'kredit' => $setoran->total_harga,
                'debit' => 0,
                'relasi' => $setoran
            ];
        })->merge($penarikans->map(function ($penarikan) {
            return (object) [
                'tanggal' => $penarikan->created_at,
                'jenis' => 'penarikan',
                'deskripsi' => 'Penarikan Saldo',
                'kredit' => 0,
                'debit' => $penarikan->jumlah_penarikan,
                'relasi' => $penarikan
            ];
        }))->sortByDesc('tanggal'); // Urutkan dari terbaru ke terlama

        // Hitung saldo berjalan
        $saldo = 0;
        $riwayatTransaksi = $transaksis->reverse()->map(function ($transaksi) use (&$saldo) {
            if ($transaksi->jenis === 'setoran') {
                $saldo += $transaksi->kredit;
            } else {
                $saldo -= $transaksi->debit;
            }
            $transaksi->saldo = $saldo;
            return $transaksi;
        })->reverse(); // Kembalikan urutan ke terbaru

        // Asumsi view Anda adalah 'pages.buku-tabungan.show'
        return view('pages.buku-tabungan.show', compact('siswa', 'riwayatTransaksi'));
    }

    /**
     * Menghasilkan PDF buku tabungan.
     * (DIPERBARUI UNTUK AKSES WALI KELAS)
     */
    public function exportPdf(Siswa $siswa)
    {
        // ==================================================
        // --- TAMBAHKAN OTORISASI YANG SAMA DI SINI ---
        // ==================================================
        $user = Auth::user();
        $isOwner = ($user->role === 'siswa' && $user->id === $siswa->id_pengguna);
        $isAdmin = ($user->role === 'admin');
        $isWaliKelas = false;
        if ($user->role === 'wali') {
            $kelasWali = $user->kelasYangDiampu;
            
            // ===================================
            // --- PERBAIKAN ADA DI BARIS INI JUGA ---
            // ===================================
            if ($kelasWali && $kelasWali->id == $siswa->id_kelas) { // <-- PERBAIKAN
                $isWaliKelas = true;
            }
        }
        // ===================================
        // --- TAMBAHAN KODE DEBUGGING ---
        // ===================================
        // Kita akan mengumpulkan semua data yang relevan untuk diinspeksi
        $debugInfo = [
            'PESAN' => 'Inspeksi variabel sebelum Abort 403',
            'user_role' => $user->role,
            'isAdmin' => $isAdmin,
            'isOwner' => $isOwner,
            'isWaliKelas' => $isWaliKelas,
            'kelas_wali_yg_login' => $kelasWali, // Ini akan null jika relasi gagal
            'id_kelas_wali' => $kelasWali ? $kelasWali->id : 'N/A',
            'siswa_yg_dilihat' => $siswa->pengguna->nama_lengkap ?? $siswa->id,
            'id_kelas_siswa' => $siswa->id_kelas,
            'perbandingan_ID' => ($kelasWali ? $kelasWali->id : 'N/A') . ' == ' . $siswa->id_kelas,
        ];

        // Jika BUKAN Admin, BUKAN Pemilik, dan BUKAN Wali Kelasnya, tolak akses
        if (!$isAdmin && !$isOwner && !$isWaliKelas) {
            
            // HENTIKAN DAN TAMPILKAN SEMUA INFO DEBUG
            dd($debugInfo); 
            
            // abort(403, 'AKSES DITOLAK'); // Baris ini sementara tidak akan tereksekusi
        }
        // ==================================================
        // --- LOGIKA OTORISASI SELESAI ---
        // ==================================================

        // ... (Sisa kode Anda untuk mengambil setoran, penarikan, dll, biarkan saja) ...
        $setorans = $siswa->setoran()->with('jenisSampah')->latest()->get();
        // ... (dst) ...
    
        if (!$isAdmin && !$isOwner && !$isWaliKelas) {
            abort(403, 'AKSES DITOLAK');
        }
        // ==================================================
        // --- LOGIKA OTORISASI SELESAI ---
        // ==================================================

        // Logic yang sama dengan show()
        $setorans = $siswa->setoran()->with('jenisSampah')->latest()->get();
        $penarikans = $siswa->penarikan()->latest()->get();

        $transaksis = $setorans->map(function ($setoran) {
            return (object) [
                'tanggal' => $setoran->created_at,
                'jenis' => 'setoran',
                'deskripsi' => 'Setoran (' . ($setoran->jenisSampah->nama_sampah ?? 'N/A') . ')',
                'kredit' => $setoran->total_harga,
                'debit' => 0,
            ];
        })->merge($penarikans->map(function ($penarikan) {
            return (object) [
                'tanggal' => $penarikan->created_at,
                'jenis' => 'penarikan',
                'deskripsi' => 'Penarikan Saldo',
                'kredit' => 0,
                'debit' => $penarikan->jumlah_penarikan,
            ];
        }))->sortByDesc('tanggal');

        $saldo = 0;
        $riwayatTransaksi = $transaksis->reverse()->map(function ($transaksi) use (&$saldo) {
            if ($transaksi->jenis === 'setoran') {
                $saldo += $transaksi->kredit;
            } else {
                $saldo -= $transaksi->debit;
            }
            $transaksi->saldo = $saldo;
            return $transaksi;
        })->reverse();

        // Asumsi view PDF Anda adalah 'pages.buku-tabungan.pdf'
        $pdf = Pdf::loadView('pages.buku-tabungan.pdf', compact('siswa', 'riwayatTransaksi'));
        return $pdf->download('buku-tabungan-' . $siswa->nis . '-' . $siswa->pengguna->nama_lengkap . '.pdf');
    }
}