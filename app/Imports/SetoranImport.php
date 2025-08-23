<?php

namespace App\Imports;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class SetoranImport implements ToCollection, WithHeadingRow
{
    public function collection(Collection $rows)
    {
        foreach ($rows as $row) 
        {
            if (empty($row['nisn']) || empty($row['jenis_sampah']) || empty($row['jumlah_kg']) || empty($row['tanggal'])) {
                continue;
            }

            $siswa = Siswa::where('nisn', $row['nisn'])->first();
            $jenisSampah = JenisSampah::where('nama_sampah', 'like', '%' . $row['jenis_sampah'] . '%')->first();

            if ($siswa && $jenisSampah) {
                Setoran::create([
                    'siswa_id' => $siswa->id,
                    'jenis_sampah_id' => $jenisSampah->id,
                    'jumlah_kg' => $row['jumlah_kg'],
                    'tanggal_setoran' => \PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($row['tanggal']),
                    'total_harga' => $row['jumlah_kg'] * $jenisSampah->harga_per_kg,
                ]);
            }
        }
    }
}