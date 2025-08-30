<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\BukuKas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PenarikanController extends Controller
{
    public function index()
    {
        // Menghapus 'admin' dari with() karena relasi sudah dihapus
        $penarikans = Penarikan::with('siswa.pengguna', 'kelas')->latest()->get();
        return view('pages.penarikan.index', compact('penarikans'));
    }

    public function create()
    {
        $siswas = Siswa::with('pengguna')->where('saldo', '>', 0)->get();
        return view('pages.penarikan.create', compact('siswas'));
    }

    public function createKelas()
    {
        $kelas = Kelas::whereHas('siswa', function ($query) {
            $query->where('saldo', '>', 0);
        })->get();
        return view('pages.penarikan.create-kelas', compact('kelas'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'jumlah_penarikan' => 'required|numeric|min:1',
        ]);

        $siswa = Siswa::with('pengguna')->findOrFail($request->id_siswa);

        if ($request->jumlah_penarikan > $siswa->saldo) {
            return back()->with('toastr-error', 'Jumlah penarikan melebihi saldo siswa.');
        }

        try {
            DB::transaction(function () use ($request, $siswa) {
                Penarikan::create([
                    // --- PERBAIKAN FINAL DI SINI ---
                    'siswa_id' => $siswa->id, 
                    'tanggal_penarikan' => now(),
                    'jumlah_penarikan' => $request->jumlah_penarikan,
                    // 'id_admin' dihapus
                ]);

                $siswa->decrement('saldo', $request->jumlah_penarikan);

                BukuKas::create([
                    'tanggal' => now(),
                    'deskripsi' => 'Penarikan saldo oleh siswa: ' . $siswa->pengguna->nama_lengkap,
                    'tipe' => 'pengeluaran',
                    'jumlah' => $request->jumlah_penarikan,
                    'id_admin' => Auth::id(),
                ]);
            });
        } catch (\Exception $e) {
            return redirect()->back()->with('toastr-error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penarikan.index')->with('toastr-success', 'Penarikan saldo berhasil.');
    }

    public function storeKelas(Request $request)
    {
        $request->validate([
            'id_kelas' => 'required|exists:kelas,id',
        ]);

        $kelas = Kelas::with('siswa.pengguna')->findOrFail($request->id_kelas);
        $totalPenarikanKelas = $kelas->siswa->sum('saldo');

        if ($totalPenarikanKelas <= 0) {
            return back()->with('toastr-error', 'Tidak ada saldo yang bisa ditarik untuk kelas ini.');
        }

        try {
            DB::transaction(function () use ($kelas, $totalPenarikanKelas) {
                Penarikan::create([
                    'id_kelas' => $kelas->id,
                    'tanggal_penarikan' => now(),
                    'jumlah_penarikan' => $totalPenarikanKelas,
                     // 'id_admin' dihapus
                ]);

                foreach ($kelas->siswa as $siswa) {
                    if ($siswa->saldo > 0) {
                        $siswa->update(['saldo' => 0]);
                    }
                }

                BukuKas::create([
                    'tanggal' => now(),
                    'deskripsi' => 'Penarikan saldo kolektif kelas: ' . $kelas->nama_kelas,
                    'tipe' => 'pengeluaran',
                    'jumlah' => $totalPenarikanKelas,
                    'id_admin' => Auth::id(),
                ]);
            });
        } catch (\Exception $e) {
            return redirect()->back()->with('toastr-error', 'Terjadi kesalahan: ' . $e->getMessage())->withInput();
        }

        return redirect()->route('penarikan.index')->with('toastr-success', 'Penarikan saldo untuk kelas ' . $kelas->nama_kelas . ' berhasil.');
    }
}