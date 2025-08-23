<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class SiswaImport implements ToCollection, WithHeadingRow
{
    public function collection(Collection $rows)
    {
        foreach ($rows as $row) 
        {
            // Pastikan kolom yang diperlukan ada
            if (empty($row['nama_lengkap']) || empty($row['username']) || empty($row['password']) || empty($row['nis']) || empty($row['kelas'])) {
                continue;
            }

            // Temukan atau buat kelas baru berdasarkan nama kelas
            $kelas = Kelas::firstOrCreate(['nama_kelas' => $row['kelas']]);

            // Gunakan NIS sebagai nama pengguna jika tidak ada
            $username = $row['username'] ?? $row['nis'];

            // Mulai transaksi database
            DB::transaction(function () use ($row, $kelas, $username) {
                // Buat akun Pengguna (User)
                $pengguna = Pengguna::firstOrCreate(
                    ['username' => $username],
                    [
                        'nama_lengkap' => $row['nama_lengkap'],
                        'password' => Hash::make($row['password']),
                        'role' => 'siswa',
                    ]
                );

                // Buat data Siswa
                Siswa::firstOrCreate(
                    ['id_pengguna' => $pengguna->id],
                    [
                        'id_kelas' => $kelas->id,
                        'nis' => $row['nis'],
                        'saldo' => 0,
                    ]
                );
            });
        }
    }
}