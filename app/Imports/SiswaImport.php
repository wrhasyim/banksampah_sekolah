<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\WithColumnFormatting; // Pastikan ini ada
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;     // Pastikan ini ada

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting // Pastikan ini ada
{
    public function model(array $row)
    {
        $kelas = Kelas::where('nama_kelas', $row['nama_kelas'])->first();

        // Buat pengguna baru
        $pengguna = Pengguna::create([
            'nama_lengkap' => $row['nama_lengkap'],
            'username' => $row['username'],
            'password' => Hash::make($row['password']),
            'role' => 'siswa',
        ]);

        // Buat siswa baru
        return new Siswa([
            'id_pengguna' => $pengguna->id,
            'id_kelas' => $kelas->id,
            'nis' => $row['nis'],
            'saldo' => 0,
        ]);
    }

    public function rules(): array
    {
        return [
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|unique:pengguna,username', // Hapus rule 'string'
            'password' => 'required',
            'nis' => 'nullable|unique:siswa,nis',
            'nama_kelas' => 'required|exists:kelas,nama_kelas',
        ];
    }
    
    public function columnFormats(): array
    {
        // Paksa kolom B (username), C (password), dan D (nis) untuk dibaca sebagai TEKS
        return [
            'B' => NumberFormat::FORMAT_TEXT, // <-- TAMBAHKAN INI
            'C' => NumberFormat::FORMAT_TEXT,
            'D' => NumberFormat::FORMAT_TEXT,
        ];
    }
}