<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\BukuKas;
use App\Models\KategoriTransaksi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;

class PenarikanController extends Controller
{
    /**
     * Menampilkan daftar permintaan penarikan.
     */
    public function index(Request $request)
    {
        $query = Penarikan::with('siswa.pengguna', 'kelas');

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($request->filled('search')) {
            $search = $request->search;
            $query->whereHas('siswa.pengguna', function ($q) use ($search) {
                $q->where('nama_lengkap', 'like', '%' . $search . '%');
            });
        }

        $penarikans = $query->latest()->paginate(10);
        return view('pages.penarikan.index', compact('penarikans'));
    }

    /**
     * Menampilkan formulir untuk membuat permintaan penarikan individu.
     */
    public function create()
    {
        $siswas = Siswa::with('pengguna')->get();
        return view('pages.penarikan.create', compact('siswas'));
    }

    /**
     * Menampilkan formulir untuk membuat permintaan penarikan per kelas.
     */
    public function createKelas()
    {
        $kelas = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.penarikan.create-kelas', compact('kelas'));
    }

    /**
     * Menyimpan permintaan penarikan individu baru.
     */
    public function store(Request $request)
    {
        $request->validate([
            'siswa_id' => 'required|exists:siswa,id',
            'jumlah_penarikan' => 'required|numeric|min:1',
        ]);

        $siswa = Siswa::find($request->siswa_id);
        if ($siswa->saldo < $request->jumlah_penarikan) {
            return back()->with('error', 'Saldo siswa tidak mencukupi.');
        }

        Penarikan::create([
            'siswa_id' => $request->siswa_id,
            'jumlah_penarikan' => $request->jumlah_penarikan,
            'tanggal_penarikan' => now(),
            'status' => 'pending',
        ]);
        
        return redirect()->route('penarikan.index')->with('success', 'Permintaan penarikan berhasil dibuat.');
    }

    /**
     * Menyimpan permintaan penarikan untuk satu kelas penuh.
     */
    public function storeKelas(Request $request)
    {
        $request->validate(['kelas_id' => 'required|exists:kelas,id']);
        
        $kelasId = $request->input('kelas_id');
        $siswaDiKelas = Siswa::where('id_kelas', $kelasId)->where('saldo', '>', 0)->get();

        if ($siswaDiKelas->isEmpty()) {
            return back()->with('error', 'Tidak ada siswa dengan saldo di kelas ini.');
        }

        foreach ($siswaDiKelas as $siswa) {
            Penarikan::create([
                'siswa_id' => $siswa->id,
                'id_kelas' => $kelasId,
                'jumlah_penarikan' => $siswa->saldo,
                'status' => 'pending',
                'tanggal_penarikan' => now(),
            ]);
        }

        return redirect()->route('penarikan.index')->with('success', 'Permintaan penarikan untuk seluruh siswa di kelas berhasil dibuat.');
    }
    
    /**
     * Memperbarui status permintaan penarikan (menyetujui atau menolak).
     */
    public function update(Request $request, Penarikan $penarikan)
    {
        $request->validate(['status' => 'required|in:disetujui,ditolak']);
        
        if ($penarikan->status === 'disetujui') {
            return back()->with('info', 'Penarikan ini sudah pernah disetujui sebelumnya.');
        }

        try {
            DB::transaction(function () use ($request, $penarikan) {
                if ($request->status == 'disetujui') {
                    $siswa = Siswa::with('pengguna')->findOrFail($penarikan->siswa_id);
                    $saldo_awal = (float) $siswa->saldo;
                    $jumlah_penarikan = (float) $penarikan->jumlah_penarikan;

                    if ($saldo_awal < $jumlah_penarikan) {
                        throw new \Exception("Saldo siswa (Rp {$saldo_awal}) tidak mencukupi untuk penarikan (Rp {$jumlah_penarikan}).");
                    }
                    
                    $saldo_baru = $saldo_awal - $jumlah_penarikan;
                    Siswa::where('id', $siswa->id)->update(['saldo' => $saldo_baru]);

                    $kategori = KategoriTransaksi::where('nama_kategori', 'Penarikan Saldo Siswa')->first();
                    if (!$kategori) {
                        throw new \Exception('Kategori transaksi "Penarikan Saldo Siswa" tidak ditemukan.');
                    }
                    
                    $keterangan = 'Penarikan Saldo oleh ' . trim($siswa->pengguna->nama_lengkap);

                    BukuKas::create([
                        'id_kategori_transaksi' => $kategori->id,
                        'keterangan' => $keterangan,
                        'deskripsi' => $keterangan,
                        'tipe' => 'pengeluaran',
                        'jumlah' => $jumlah_penarikan,
                        'tanggal' => now(),
                        'id_admin' => Auth::id(),
                    ]);
                }

                $penarikan->status = $request->status;
                $penarikan->save();
            });

            return redirect()->route('penarikan.index')->with('success', 'Status penarikan berhasil diperbarui.');

        } catch (\Throwable $e) {
            Log::error("GAGAL memproses penarikan ID {$penarikan->id}: " . $e->getMessage());
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
        }
    }
}