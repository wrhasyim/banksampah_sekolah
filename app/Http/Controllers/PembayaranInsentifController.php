<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\PembayaranInsentif;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class PembayaranInsentifController extends Controller
{
    // Menampilkan halaman rekap & pembayaran
    public function index()
    {
        $insentifPerKelas = Insentif::where('status_pembayaran', 'belum dibayar')
            ->with('kelas.waliKelas')
            ->select('kelas_id', DB::raw('SUM(jumlah_insentif) as total_insentif'))
            ->groupBy('kelas_id')
            ->get();

        return view('pages.insentif.pembayaran', compact('insentifPerKelas'));
    }

    // Memproses pembayaran
    public function store(Request $request)
    {
        $request->validate([
            'pembayaran' => 'required|array|min:1',
            'pembayaran.*.kelas_id' => 'required|exists:kelas,id',
            'pembayaran.*.jumlah' => 'required|numeric|min:1',
        ]);

        DB::transaction(function () use ($request) {
            foreach ($request->pembayaran as $bayar) {
                $kelasId = $bayar['kelas_id'];
                $jumlahDibayar = $bayar['jumlah'];
                $kelas = Kelas::find($kelasId);

                // 1. Buat catatan riwayat pembayaran
                $pembayaran = PembayaranInsentif::create([
                    'id_admin' => Auth::id(),
                    'tanggal_pembayaran' => now(),
                    'total_dibayar' => $jumlahDibayar,
                    'keterangan' => 'Pembayaran insentif untuk Wali Kelas: ' . ($kelas->waliKelas->nama_lengkap ?? 'N/A'),
                ]);

                // 2. Catat sebagai pengeluaran di Buku Kas
                BukuKas::create([
                    'tanggal' => now(),
                    'deskripsi' => 'Pembayaran Insentif Wali Kelas: ' . ($kelas->nama_kelas ?? 'Kelas Dihapus'),
                    'tipe' => 'pengeluaran',
                    'jumlah' => $jumlahDibayar,
                    'id_admin' => Auth::id(),
                ]);

                // 3. Update status insentif yang terkait
                Insentif::where('kelas_id', $kelasId)
                    ->where('status_pembayaran', 'belum dibayar')
                    ->update([
                        'status_pembayaran' => 'sudah dibayar',
                        'pembayaran_insentif_id' => $pembayaran->id,
                    ]);
            }
        });

        return redirect()->route('insentif.index')->with('success', 'Pembayaran insentif berhasil dicatat.');
    }
}

// Buat juga model untuk PembayaranInsentif
// Buat file app/Models/PembayaranInsentif.php
/*
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PembayaranInsentif extends Model
{
    use HasFactory;
    protected $fillable = ['id_admin', 'tanggal_pembayaran', 'total_dibayar', 'keterangan'];
}
*/