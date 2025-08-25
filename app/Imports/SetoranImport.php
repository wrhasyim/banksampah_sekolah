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
use Illuminate\Validation\ValidationException;

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

        // Jika salah satu tidak ditemukan, lemparkan error validasi
        if (!$siswa) {
            throw ValidationException::withMessages([
                'file' => 'Kombinasi siswa "' . ($row['nama_siswa'] ?? '') . '" dan kelas "' . ($row['nama_kelas'] ?? '') . '" tidak ditemukan.'
            ]);
        }
        if (!$jenisSampah) {
            throw ValidationException::withMessages([
                'file' => 'Jenis sampah "' . ($row['nama_sampah'] ?? '') . '" tidak ditemukan.'
            ]);
        }

        // 3. Jika semua data valid, lakukan transaksi
        DB::transaction(function () use ($siswa, $jenisSampah, $row) {
            // Ganti 'jumlah_satuan' menjadi 'jumlah'
            $totalHarga = $jenisSampah->harga_per_satuan * $row['jumlah'];

            Setoran::create([
                'id_siswa' => $siswa->id,
                'id_jenis_sampah' => $jenisSampah->id,
                'id_admin' => Auth::id(),
                'jumlah' => $row['jumlah'], // Ganti 'jumlah_satuan' menjadi 'jumlah'
                'total_harga' => $totalHarga,
            ]);

            $siswa->increment('saldo', $totalHarga);
            $jenisSampah->increment('stok', $row['jumlah']); // Ganti 'jumlah_satuan' menjadi 'jumlah'
        });

        return null;
    }

    public function rules(): array
    {
        return [
            'nama_siswa' => 'required|string',
            'nama_kelas' => 'required|string',
            'nama_sampah' => 'required|string',
            'jumlah' => 'required|numeric|min:0.01', // Ganti 'jumlah_satuan' menjadi 'jumlah'
        ];
    }
}