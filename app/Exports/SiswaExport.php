<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Collection;

class SiswaExport implements FromCollection, WithHeadings
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        // Mengembalikan koleksi kosong untuk template
        return new Collection();
    }

    /**
    * @return array
    */
    public function headings(): array
    {
        // Header yang dibutuhkan untuk impor siswa
        return [
            'nama',
            'nisn',
            'nis',
            'email',
            'tanggal_lahir',
            'jenis_kelamin',
            'alamat',
            'nomor_telepon',
            'kelas', // Nama kelas
        ];
    }
}