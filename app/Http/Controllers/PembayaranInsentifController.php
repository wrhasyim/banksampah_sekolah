<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi; // Ditambahkan untuk integrasi
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
     * Menyimpan data pembayaran insentif untuk wali kelas yang dipilih.
     */
    public function store(Request $request)
    {
        $request->validate([
            'pembayaran' => 'required|array',
        ], [
            'pembayaran.required' => 'Anda harus memilih setidaknya satu wali kelas untuk dibayar.',
        ]);

        try {
            DB::transaction(function () use ($request) {
                
                $pembayaranDiproses = 0;
                // Ambil kategori transaksi di luar loop untuk efisiensi
                $kategori = KategoriTransaksi::firstOrCreate(
                    ['nama_kategori' => 'Pembayaran Insentif Guru'],
                    ['tipe' => 'pengeluaran']
                );

                foreach ($request->pembayaran as $data) {
                    
                    // Proses HANYA jika checkbox 'status' dicentang
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

                            // 2. PERBAIKAN: Catat sebagai pengeluaran di Buku Kas dengan skema yang benar
                            BukuKas::create([
                                'tanggal' => now(),
                                'deskripsi' => 'Pembayaran Insentif Wali Kelas: ' . ($kelas->waliKelas->nama_lengkap ?? 'N/A'),
                                'tipe' => 'pengeluaran', // Sesuai dengan skema tabel Anda
                                'jumlah' => $jumlahDibayar,
                                'id_admin' => Auth::id(),
                                'id_kategori' => $kategori->id, // Menggunakan id_kategori
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
                }

                // PERBAIKAN: Jika tidak ada checkbox yang dicentang, batalkan transaksi dengan melempar exception
                if ($pembayaranDiproses === 0) {
                    throw new \Exception('Tidak ada wali kelas yang dipilih untuk pembayaran. Harap centang kotak "Bayar".');
                }
            });

        } catch (\Exception $e) {
            // PERBAIKAN: Tangkap error dari transaksi dan kembalikan pesan yang jelas
            return redirect()->route('insentif.pembayaran')->with('error', $e->getMessage());
        }

        return redirect()->route('insentif.index')->with('success', 'Pembayaran insentif untuk wali kelas yang dipilih berhasil dicatat.');
    }
}