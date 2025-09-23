<?php

namespace App\Http\Controllers;

use App\Models\Penarikan;
use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\BukuKas; // <-- TAMBAHKAN INI
use App\Models\KategoriTransaksi; // <-- TAMBAHKAN INI
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PenarikanController extends Controller
{
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

    public function create()
    {
        $siswa = Siswa::with('pengguna')->get();
        return view('pages.penarikan.create', compact('siswa'));
    }

    public function createKelas()
    {
        $kelasList = Kelas::orderBy('nama_kelas', 'asc')->get();
        return view('pages.penarikan.create-kelas', compact('kelasList'));
    }

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

        Penarikan::create($request->all());
        return redirect()->route('penarikan.index')->with('success', 'Permintaan penarikan berhasil dibuat.');
    }

    public function storeKelas(Request $request)
    {
        $kelasId = $request->input('kelas_id');
        $siswaDiKelas = Siswa::where('id_kelas', $kelasId)->where('saldo', '>', 0)->get();

        if ($siswaDiKelas->isEmpty()) {
            return back()->with('error', 'Tidak ada siswa dengan saldo di kelas ini.');
        }

        foreach ($siswaDiKelas as $siswa) {
            Penarikan::create([
                'siswa_id' => $siswa->id,
                'jumlah_penarikan' => $siswa->saldo,
                'status' => 'pending',
                'id_kelas' => $kelasId,
            ]);
        }

        return redirect()->route('penarikan.index')->with('success', 'Permintaan penarikan untuk kelas berhasil dibuat.');
    }

    public function update(Request $request, Penarikan $penarikan)
    {
        $request->validate(['status' => 'required|in:disetujui,ditolak']);

        DB::transaction(function () use ($request, $penarikan) {
            $penarikan->update(['status' => $request->status]);

            if ($request->status == 'disetujui') {
                $siswa = Siswa::with('pengguna')->find($penarikan->siswa_id);
                if ($siswa->saldo < $penarikan->jumlah_penarikan) {
                    throw new \Exception('Saldo siswa tidak mencukupi.');
                }
                $siswa->decrement('saldo', $penarikan->jumlah_penarikan);

                // --- INTEGRASI BUKU KAS DIMULAI DI SINI ---
                $kategori = KategoriTransaksi::where('nama_kategori', 'Penarikan Saldo Siswa')->first();
                
                BukuKas::create([
                    'id_kategori_transaksi' => $kategori ? $kategori->id : null,
                    'keterangan' => 'Penarikan Saldo oleh ' . $siswa->pengguna->nama_lengkap,
                    'tipe' => 'keluar',
                    'jumlah' => $penarikan->jumlah_penarikan,
                    'created_at' => now(),
                ]);
                // --- INTEGRASI BUKU KAS SELESAI ---
            }
        });

        return redirect()->route('penarikan.index')->with('success', 'Status penarikan berhasil diperbarui.');
    }
}