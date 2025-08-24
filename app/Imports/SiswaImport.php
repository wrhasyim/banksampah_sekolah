<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\WithColumnFormatting; // <-- 1. Tambahkan ini
use PhpOffice\PhpSpreadsheet\Style\NumberFormat; // <-- 2. Tambahkan ini

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting // <-- 3. Tambahkan ini
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
            'username' => 'required|string|max:50|unique:pengguna,username',
            'password' => 'required', // Hapus rule 'string', karena sudah kita format
            'nis' => 'nullable|unique:siswa,nis', // Hapus rule 'string'
            'nama_kelas' => 'required|exists:kelas,nama_kelas',
        ];
    }
    
    // <-- 4. Tambahkan metode baru ini
    public function columnFormats(): array
    {
        // Paksa kolom C (password) dan D (nis) untuk dibaca sebagai TEKS
        return [
            'C' => NumberFormat::FORMAT_TEXT,
            'D' => NumberFormat::FORMAT_TEXT,
        ];
    }
}