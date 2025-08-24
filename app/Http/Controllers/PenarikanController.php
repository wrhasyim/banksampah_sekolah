<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
use App\Models\Kelas; // Pastikan ini ditambahkan
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PenarikanController extends Controller
{
    public function index()
    {
        $penarikan = Penarikan::with(['siswa.pengguna', 'admin'])->latest()->get();
        return view('pages.penarikan.index', compact('penarikan'));
    }

    public function create()
    {
        $siswa = Siswa::with('pengguna')->get();
        return view('pages.penarikan.create', compact('siswa'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'jumlah_penarikan' => 'required|numeric|min:1',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $siswa = Siswa::findOrFail($request->id_siswa);

                if ($siswa->saldo < $request->jumlah_penarikan) {
                    throw new \Exception('Saldo siswa tidak mencukupi untuk melakukan penarikan.');
                }

                Penarikan::create([
                    'id_siswa' => $request->id_siswa,
                    'id_admin' => Auth::id(),
                    'jumlah_penarikan' => $request->jumlah_penarikan,
                ]);

                $siswa->saldo -= $request->jumlah_penarikan;
                $siswa->save();
            });
        } catch (\Exception $e) {
            return redirect()->route('penarikan.create')->with('error', $e->getMessage());
        }

        return redirect()->route('penarikan.index')->with('status', 'Transaksi penarikan berhasil disimpan!');
    }

    // --- DUA METODE BARU DITAMBAHKAN DI SINI ---

    /**
     * Menampilkan form untuk penarikan per kelas.
     */
    public function createKelas()
    {
        $kelas = Kelas::with('siswa')->get();
        return view('pages.penarikan.create-kelas', compact('kelas'));
    }

    /**
     * Menyimpan transaksi penarikan per kelas.
     */
    public function storeKelas(Request $request)
    {
        $request->validate([
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $kelas = Kelas::with('siswa')->findOrFail($request->id_kelas);
                $siswaDiKelas = $kelas->siswa;

                if ($siswaDiKelas->isEmpty()) {
                    throw new \Exception('Tidak ada siswa di kelas ini.');
                }
                
                $totalSaldoDitarik = 0;

                // Loop hanya untuk menghitung total dan mengurangi saldo siswa
                foreach ($siswaDiKelas as $siswa) {
                    if ($siswa->saldo > 0) {
                        $totalSaldoDitarik += $siswa->saldo;
                        $siswa->update(['saldo' => 0]); // Set saldo menjadi 0
                    }
                }
                
                if ($totalSaldoDitarik == 0) {
                    throw new \Exception('Semua siswa di kelas ini sudah memiliki saldo nol.');
                }

                // Buat SATU catatan penarikan untuk seluruh kelas
                Penarikan::create([
                    'id_admin' => Auth::id(),
                    'id_kelas' => $kelas->id, // Catat ID kelasnya
                    'id_siswa' => null,      // Biarkan ID siswa kosong
                    'jumlah_penarikan' => $totalSaldoDitarik,
                ]);
            });
        } catch (\Exception $e) {
            return redirect()->back()->with('error', $e->getMessage())->withInput();
        }

        return redirect()->route('penarikan.index')->with('status', 'Penarikan seluruh saldo untuk kelas ' . Kelas::find($request->id_kelas)->nama_kelas . ' berhasil!');
    }
}