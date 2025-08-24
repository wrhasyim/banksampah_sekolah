<?php

namespace App\Imports;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Validation\ValidationException; // <-- Tambahkan ini

class SetoranImport implements ToModel, WithHeadingRow, WithValidation
{
    public function model(array $row)
    {
        // 1. Cari siswa berdasarkan NAMA dan KELAS
        $siswa = Siswa::whereHas('pengguna', function ($query) use ($row) {
            $query->where('nama_lengkap', $row['nama_siswa']);
        })->whereHas('kelas', function ($query) use ($row) {
            $query->where('nama_kelas', $row['nama_kelas']);
        })->first();

        // 2. Cari jenis sampah berdasarkan NAMA
        $jenisSampah = JenisSampah::where('nama_sampah', $row['nama_sampah'])->first();

        // --- INI LOGIKA BARUNYA ---
        // Jika salah satu tidak ditemukan, buat dan lemparkan error validasi
        if (!$siswa) {
            throw ValidationException::withMessages([
                'file' => 'Kombinasi siswa "' . $row['nama_siswa'] . '" dan kelas "' . $row['nama_kelas'] . '" tidak ditemukan.'
            ]);
        }
        if (!$jenisSampah) {
            throw ValidationException::withMessages([
                'file' => 'Jenis sampah "' . $row['nama_sampah'] . '" tidak ditemukan.'
            ]);
        }
        // --- AKHIR LOGIKA BARU ---

        // 3. Jika semua data valid, lakukan transaksi
        DB::transaction(function () use ($siswa, $jenisSampah, $row) {
            $totalHarga = $jenisSampah->harga_per_satuan * $row['jumlah_satuan'];

            Setoran::create([
                'id_siswa' => $siswa->id,
                'id_jenis_sampah' => $jenisSampah->id,
                'id_admin' => Auth::id(),
                'jumlah_satuan' => $row['jumlah_satuan'],
                'total_harga' => $totalHarga,
            ]);

            $siswa->increment('saldo', $totalHarga);
        });

        return null;
    }

    public function rules(): array
    {
        // Kita hanya perlu validasi dasar di sini
        return [
            'nama_siswa' => 'required|string',
            'nama_kelas' => 'required|string',
            'nama_sampah' => 'required|string',
            'jumlah_satuan' => 'required|numeric|min:1',
        ];
    }
}