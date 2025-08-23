<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Illuminate\Support\Facades\Hash;

class SiswaImport implements ToCollection, WithHeadingRow
{
    public function collection(Collection $rows)
    {
        foreach ($rows as $row) 
        {
            if (empty($row['nama']) || empty($row['nisn']) || empty($row['nis']) || empty($row['kelas'])) {
                continue;
            }

            // Temukan atau buat kelas baru
            $kelas = Kelas::firstOrCreate(['nama_kelas' => $row['kelas']]);

            // Buat akun Pengguna (User)
            $pengguna = Pengguna::create([
                'nama' => $row['nama'],
                'email' => $row['email'] ?? $row['nisn'] . '@sekolah.sch.id',
                'password' => Hash::make($row['nisn']), // NISN sebagai password default
                'role' => 'siswa',
            ]);

            // Buat data Siswa
            Siswa::create([
                'pengguna_id' => $pengguna->id,
                'nama_siswa' => $row['nama'],
                'nisn' => $row['nisn'],
                'nis' => $row['nis'],
                'alamat' => $row['alamat'] ?? '-',
                'jenis_kelamin' => $row['jenis_kelamin'] ?? '-',
                'tanggal_lahir' => \PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($row['tanggal_lahir']),
                'nomor_telepon' => $row['nomor_telepon'] ?? '-',
                'kelas_id' => $kelas->id,
            ]);
        }
    }
}