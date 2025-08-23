<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class SiswaImport implements ToCollection, WithHeadingRow, WithValidation
{
    public function collection(Collection $rows)
    {
        foreach ($rows as $row) 
        {
            $kelas = Kelas::where('nama_kelas', $row['kelas'])->first();

            DB::transaction(function () use ($row, $kelas) {
                $pengguna = Pengguna::create([
                    'nama_lengkap' => $row['nama_lengkap'],
                    'username' => $row['username'],
                    'password' => Hash::make($row['password']),
                    'role' => 'siswa',
                ]);

                Siswa::create([
                    'id_pengguna' => $pengguna->id,
                    'id_kelas' => $kelas->id,
                    'nis' => $row['nis'],
                    'saldo' => 0,
                ]);
            });
        }
    }

    public function rules(): array
    {
        return [
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|unique:pengguna,username|max:255',
            'password' => 'required|string|min:8',
            'nis' => 'required|string|unique:siswa,nis|max:255',
            'kelas' => 'required|string|exists:kelas,nama_kelas',
        ];
    }
}