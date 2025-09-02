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
        $request->validate([
            'pembayaran' => 'required|array',
        ], [
            'pembayaran.required' => 'Anda harus memilih setidaknya satu wali kelas untuk dibayar.',
        ]);

        DB::transaction(function () use ($request) {
            
            $pembayaranDiproses = 0;

            // Loop pada semua data pembayaran yang dikirim dari form
            foreach ($request->pembayaran as $data) {
                
                // =================== LOGIKA KUNCI DI SINI ===================
                // Proses HANYA jika checkbox 'status' ada dan nilainya 'bayar'
                if (isset($data['status']) && $data['status'] === 'bayar') {
                    
                    $kelasId = $data['kelas_id'];
                    $jumlahDibayar = $data['jumlah'];
                    $kelas = Kelas::with('waliKelas')->find($kelasId);

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

                        // 3. Update status semua insentif yang terkait
                        Insentif::where('kelas_id', $kelasId)
                            ->where('status_pembayaran', 'belum dibayar')
                            ->update([
                                'status_pembayaran' => 'sudah dibayar',
                                'pembayaran_insentif_id' => $pembayaran->id,
                            ]);
                        
                        $pembayaranDiproses++;
                    }
                }
                // =================== AKHIR LOGIKA KUNCI ===================
            }

            // Jika tidak ada checkbox yang dicentang sama sekali
            if ($pembayaranDiproses === 0) {
                // Batalkan transaksi dan kembalikan dengan pesan error
                return back()->with('error', 'Tidak ada wali kelas yang dipilih untuk pembayaran.');
            }
        });

        // Cek apakah ada pesan error dari dalam transaksi
        if (session('error')) {
            return redirect()->route('insentif.pembayaran')->with('error', session('error'));
        }

        return redirect()->route('insentif.index')->with('success', 'Pembayaran insentif untuk wali kelas yang dipilih berhasil dicatat.');
    }
}