<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Penarikan;

class BukuTabunganController extends Controller
{
    /**
     * Menampilkan halaman utama buku tabungan dengan form pencarian.
     */
    public function index()
    {
        // KIRIMKAN VARIABEL $results SEBAGAI ARRAY KOSONG
        $results = []; 
        return view('pages.buku-tabungan.index', compact('results'));
    }

    /**
     * Mencari siswa berdasarkan nama dan menampilkan hasilnya.
     */
    public function search(Request $request)
    {
        $request->validate(['query' => 'required|string|max:100']);
        $query = $request->input('query');
        $results = Siswa::where('nama_siswa', 'like', "%$query%")->get();

        return view('pages.buku-tabungan.index', compact('results', 'query'));
    }

    /**
     * Menampilkan detail tabungan seorang siswa.
     */
    public function show(Siswa $siswa)
    {
        $setorans = Setoran::where('siswa_id', $siswa->id)->latest('tanggal_setor')->paginate(10);
        $penarikans = Penarikan::where('siswa_id', $siswa->id)->latest('tanggal_penarikan')->paginate(10);
        $saldo = $siswa->saldo;

        return view('pages.buku-tabungan.show', compact('siswa', 'setorans', 'penarikans', 'saldo'));
    }
}