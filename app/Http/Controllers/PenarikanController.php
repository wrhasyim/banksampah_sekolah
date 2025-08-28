<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\Penarikan;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PenarikanController extends Controller
{
    public function index()
    {
        $penarikan = Penarikan::with('siswa.pengguna')->latest()->get();
        return view('pages.penarikan.index', compact('penarikan'));
    }

    public function create()
    {
        $siswa = Siswa::with('kelas')->get();
    return view('pages.penarikan.create', compact('siswa'));
        
    }

    public function createKelas()
    {
        return view('pages.penarikan.create-kelas', [
            'kelas' => Kelas::with('siswa')->get(),
        ]);
    }

    /**
     * PERBAIKAN: Method baru untuk menyimpan penarikan per kelas.
     */
    public function storeKelas(Request $request)
    {
        $request->validate([
            'id_kelas' => 'required|exists:kelas,id',
            'jumlah' => 'required|numeric|min:1',
        ]);

        $kelas = Kelas::with('siswa')->find($request->id_kelas);
        $jumlahPenarikan = $request->jumlah;

        DB::beginTransaction();
        try {
            foreach ($kelas->siswa as $siswa) {
                if ($siswa->saldo >= $jumlahPenarikan) {
                    $siswa->saldo -= $jumlahPenarikan;
                    $siswa->save();

                    Penarikan::create([
                        'siswa_id' => $siswa->id,
                        'jumlah' => $jumlahPenarikan,
                        'id_admin' => auth()->id(),
                        'tanggal_penarikan' => now(),
                    ]);
                }
            }
            DB::commit();
            return redirect()->route('penarikan.index')->with('success', 'Penarikan untuk kelas ' . $kelas->nama . ' berhasil diproses.');
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Terjadi kesalahan saat memproses penarikan.');
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'siswa_id' => 'required|exists:siswa,id',
            'jumlah' => 'required|numeric|min:1',
        ]);

        $siswa = Siswa::find($request->siswa_id);

        if ($siswa->saldo < $request->jumlah) {
            return redirect()->back()->with('error', 'Saldo siswa tidak mencukupi.');
        }

        $siswa->saldo -= $request->jumlah;
        $siswa->save();

        Penarikan::create([
            'siswa_id' => $request->siswa_id,
            'jumlah' => $request->jumlah,
            'id_admin' => auth()->id(),
            'tanggal_penarikan' => now(),
        ]);

        return redirect()->route('penarikan.index')->with('success', 'Penarikan berhasil ditambahkan.');
    }

    public function destroy(Penarikan $penarikan)
    {
        $siswa = Siswa::find($penarikan->siswa_id);
        $siswa->saldo += $penarikan->jumlah;
        $siswa->save();
        
        $penarikan->delete();

        return redirect()->route('penarikan.index')->with('success', 'Data penarikan berhasil dihapus.');
    }
}