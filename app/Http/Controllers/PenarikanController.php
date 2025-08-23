<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
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

                // Validasi apakah saldo mencukupi
                if ($siswa->saldo < $request->jumlah_penarikan) {
                    // Jika tidak cukup, lemparkan exception untuk membatalkan transaksi
                    throw new \Exception('Saldo siswa tidak mencukupi untuk melakukan penarikan.');
                }

                // 1. Buat record penarikan baru
                Penarikan::create([
                    'id_siswa' => $request->id_siswa,
                    'id_admin' => Auth::id(),
                    'jumlah_penarikan' => $request->jumlah_penarikan,
                ]);

                // 2. Kurangi saldo siswa
                $siswa->saldo -= $request->jumlah_penarikan;
                $siswa->save();
            });
        } catch (\Exception $e) {
            // Tangkap pesan error dari validasi saldo
            return redirect()->route('penarikan.create')->with('error', $e->getMessage());
        }

        return redirect()->route('penarikan.index')->with('status', 'Transaksi penarikan berhasil disimpan!');
    }
}