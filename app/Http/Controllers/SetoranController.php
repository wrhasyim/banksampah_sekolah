<?php

namespace App\Http\Controllers;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Validators\ValidationException;
use App\Imports\SetoranImport;
use App\Exports\SetoranExport;
use App\Exports\SetoranSampleExport;

class SetoranController extends Controller
{
    public function index()
    {
        $setoran = Setoran::with(['siswa.pengguna', 'jenisSampah', 'admin'])->latest()->get();

        return view('pages.setoran.index', compact('setoran'));
    }

    public function create()
    {
        $kelas = Kelas::all();
        $jenisSampah = JenisSampah::all();
        return view('pages.setoran.create', compact('kelas', 'jenisSampah'));
    }
    public function exportSample()
    {
        return \Maatwebsite\Excel\Facades\Excel::download(new SetoranSampleExport, 'contoh-impor-setoran.xlsx');
    }
    public function store(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:siswa,id',
            'id_jenis_sampah' => 'required|exists:jenis_sampah,id',
            'jumlah_satuan' => 'required|integer|min:1',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $siswa = Siswa::findOrFail($request->id_siswa);
                $jenisSampah = JenisSampah::findOrFail($request->id_jenis_sampah);

                $totalHarga = $jenisSampah->harga_per_satuan * $request->jumlah_satuan;

        $siswa = Siswa::with('pengguna')->findOrFail($request->id_siswa);
        $jenisSampah = JenisSampah::findOrFail($request->id_jenis_sampah);

        DB::transaction(function () use ($request, $siswa, $jenisSampah) {
            $total_harga = $request->jumlah_satuan * $jenisSampah->harga_per_satuan;

            Setoran::create([
                'id_siswa' => $siswa->id,
                'id_jenis_sampah' => $jenisSampah->id,
                'id_admin' => Auth::id(),
                'jumlah_satuan' => $request->jumlah_satuan,
                'total_harga' => $total_harga,
            ]);

            $siswa->saldo += $total_harga;
            $siswa->save();

        });
        // 2. Tambahkan saldo siswa
                $siswa->increment('saldo', $totalHarga);

                // 3. TAMBAHKAN STOK SAMPAH
                $jenisSampah->increment('stok', $request->jumlah_satuan);
            });
        } catch (\Exception $e) {
            return redirect()->route('setoran.create')->with('error', 'Terjadi kesalahan saat menyimpan transaksi.');
        }

        return redirect()->route('setoran.index')->with('status', 'Transaksi setoran berhasil disimpan!');
        return redirect()->route('setoran.index')->with('status', 'Setoran baru berhasil dicatat!');
    }

    public function getSiswaByKelas($id_kelas)
    {
        $siswa = Siswa::with('pengguna')
                      ->where('id_kelas', $id_kelas)
                      ->get()
                      ->map(function ($item) {
                          return [
                              'id' => $item->id,
                              'nama' => $item->pengguna->nama_lengkap,
                          ];
                      });
        return response()->json($siswa);
    }
    
    public function showImportForm()
    {
        // Ambil 1 data jenis sampah dan 1 data siswa untuk ditampilkan sebagai referensi
        $jenisSampah = \App\Models\JenisSampah::take(1)->get(); // <-- UBAH DI SINI
        $siswa = \App\Models\Siswa::with(['pengguna', 'kelas'])->take(1)->get(); // <-- UBAH DI SINI

        // Kirim kedua variabel ke view
        return view('pages.setoran.import', compact('jenisSampah', 'siswa'));
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        try {
            \Maatwebsite\Excel\Facades\Excel::import(new \App\Imports\SetoranImport, $request->file('file'));
        
        // Tangkap error validasi dari dalam file Excel
        } catch (ValidationException $e) {
            $failures = $e->failures();
            $errorMessages = [];
            foreach ($failures as $failure) {
                // Kumpulkan semua pesan error untuk setiap baris yang gagal
                $errorMessages[] = 'Baris ' . $failure->row() . ': ' . implode(', ', $failure->errors());
            }
            // Kirim kembali pesan error yang jelas ke halaman impor
            return redirect()->route('setoran.import.form')->withErrors($errorMessages);
        }

        // Jika berhasil, kirim pesan sukses
        return redirect()->route('setoran.import.form')->with('success', 'Data setoran berhasil diimpor!');
    }

}