<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\PembayaranInsentif;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class PembayaranInsentifController extends Controller
{
    /**
     * Menampilkan halaman rekapitulasi dan formulir pembayaran insentif.
     */
    public function index()
    {
        $insentifPerKelas = Insentif::where('status_pembayaran', 'belum dibayar')
            ->with('kelas.waliKelas')
            ->select('kelas_id', DB::raw('SUM(jumlah_insentif) as total_insentif'))
            ->groupBy('kelas_id')
            ->havingRaw('SUM(jumlah_insentif) > 0')
            ->get();

        return view('pages.insentif.pembayaran', compact('insentifPerKelas'));
    }

    /**
     * Menyimpan data pembayaran insentif HANYA untuk wali kelas yang dipilih.
     */
    public function store(Request $request)
    {
        // Validasi untuk memastikan setidaknya satu wali kelas dipilih
        $request->validate([
            'pembayaran' => 'required|array|min:1',
            'pembayaran.*.kelas_id' => 'required|exists:kelas,id',
            'pembayaran.*.jumlah' => 'required|numeric|min:1',
        ], [
            'pembayaran.required' => 'Anda harus memilih setidaknya satu wali kelas untuk dibayar.',
            'pembayaran.min' => 'Anda harus memilih setidaknya satu wali kelas untuk dibayar.'
        ]);

        DB::transaction(function () use ($request) {
            
            // Loop HANYA pada data pembayaran yang dikirim dari form (yang dicentang)
            foreach ($request->pembayaran as $bayar) {
                
                // Pastikan data yang dikirim valid dan lengkap
                if (isset($bayar['kelas_id']) && isset($bayar['jumlah'])) {
                    $kelasId = $bayar['kelas_id'];
                    $jumlahDibayar = $bayar['jumlah'];
                    
                    $kelas = Kelas::with('waliKelas')->find($kelasId);

                    // Lanjutkan hanya jika kelas dan wali kelas ada
                    if ($kelas && $kelas->waliKelas) {
                        // 1. Buat catatan riwayat pembayaran
                        $pembayaran = PembayaranInsentif::create([
                            'id_admin' => Auth::id(),
                            'id_wali_kelas' => $kelas->id_wali_kelas,
                            'tanggal_pembayaran' => now(),
                            'total_dibayar' => $jumlahDibayar,
                            'keterangan' => 'Pembayaran Insentif untuk Wali Kelas: ' . ($kelas->waliKelas->nama_lengkap ?? 'N/A'),
                        ]);

                        // 2. Catat sebagai pengeluaran di Buku Kas
                        BukuKas::create([
                            'tanggal' => now(),
                            'deskripsi' => 'Pembayaran Insentif Wali Kelas: ' . ($kelas->waliKelas->nama_lengkap ?? 'N/A'),
                            'tipe' => 'pengeluaran',
                            'jumlah' => $jumlahDibayar,
                            'id_admin' => Auth::id(),
                        ]);

                        // 3. Update status semua insentif yang terkait dengan kelas ini
                        Insentif::where('kelas_id', $kelasId)
                            ->where('status_pembayaran', 'belum dibayar')
                            ->update([
                                'status_pembayaran' => 'sudah dibayar',
                                'pembayaran_insentif_id' => $pembayaran->id,
                            ]);
                    }
                }
            }
        });

        return redirect()->route('insentif.index')->with('success', 'Pembayaran insentif untuk wali kelas yang dipilih berhasil dicatat.');
    }
}