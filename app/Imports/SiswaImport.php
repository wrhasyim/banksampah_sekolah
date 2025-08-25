<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use Illuminate\Contracts\Queue\ShouldQueue;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\Importable; // <-- 1. TAMBAHKAN INI

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting, ShouldQueue, WithChunkReading
{
    use Importable; // <-- 2. TAMBAHKAN INI

    public function model(array $row)
    {
        $kelas = Kelas::where('nama_kelas', $row['nama_kelas'])->first();

        $pengguna = Pengguna::create([
            'nama_lengkap' => $row['nama_lengkap'],
            'username' => $row['username'],
            'password' => Hash::make($row['password']),
            'role' => 'siswa',
        ]);

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
            'username' => 'required|unique:pengguna,username',
            'password' => 'required',
            'nis' => 'nullable|unique:siswa,nis',
            'nama_kelas' => 'required|exists:kelas,nama_kelas',
        ];
    }
    
    public function columnFormats(): array
    {
        return [
            'B' => NumberFormat::FORMAT_TEXT,
            'C' => NumberFormat::FORMAT_TEXT,
            'D' => NumberFormat::FORMAT_TEXT,
        ];
    }

    public function chunkSize(): int
    {
        return 100;
    }
}