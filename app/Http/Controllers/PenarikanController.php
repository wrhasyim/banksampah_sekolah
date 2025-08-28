<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PenarikanController extends Controller
{
    public function index()
    {
        $penarikans = Penarikan::orderBy('created_at', 'desc')->get();
        return view('pages.penarikan.index', compact('penarikans'));
    }

    public function create()
    {
        $siswas = Siswa::all();
        return view('pages.penarikan.create', compact('siswas'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'jumlah' => 'required|numeric|min:1',
        ]);

        $siswa = Siswa::findOrFail($request->id_siswa);

        if ($request->jumlah > $siswa->saldo) {
            return redirect()->back()->with('error', 'Saldo tidak mencukupi.');
        }

        DB::transaction(function () use ($request, $siswa) {
            Penarikan::create([
                'id_siswa' => $request->id_siswa,
                'jumlah' => $request->jumlah,
            ]);

            $siswa->decrement('saldo', $request->jumlah);
        });

        return redirect()->route('penarikan.index')->with('success', 'Penarikan berhasil ditambahkan.');
    }

    public function createKelas()
    {
        $kelas = Kelas::all();
        $siswas = Siswa::all();
        return view('pages.penarikan.create-kelas', compact('kelas', 'siswas'));
    }

    public function storeKelas(Request $request)
    {
        $request->validate([
            'id_kelas' => 'required|exists:kelas,id',
        ]);
    
        $siswas = Siswa::where('id_kelas', $request->id_kelas)->get();
        $penarikanCount = 0;
    
        DB::transaction(function () use ($siswas, &$penarikanCount) {
            foreach ($siswas as $siswa) {
                // Lakukan penarikan hanya jika siswa memiliki saldo
                if ($siswa->saldo > 0) {
                    Penarikan::create([
                        'id_siswa' => $siswa->id,
                        'id_kelas' => $request->id_kelas,
                        'jumlah' => $siswa->saldo, // Ambil seluruh saldo
                        'tipe' => 'kelas',
                    ]);
    
                    // Nolkan saldo siswa
                    $siswa->update(['saldo' => 0]);
                    $penarikanCount++;
                }
            }
        });
    
        if ($penarikanCount > 0) {
            return redirect()->route('penarikan.index')->with('success', "Berhasil mengosongkan saldo untuk {$penarikanCount} siswa.");
        } else {
            return redirect()->route('penarikan.index')->with('info', 'Tidak ada siswa di kelas tersebut yang memiliki saldo untuk ditarik.');
        }
    }
}