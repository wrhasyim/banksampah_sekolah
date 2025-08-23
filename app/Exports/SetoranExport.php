<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Collection;

class SetoranExport implements FromCollection, WithHeadings
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
        // Header yang dibutuhkan untuk impor setoran
        return [
            'nisn', // NISN siswa
            'jenis_sampah',
            'jumlah_kg',
            'tanggal',
        ];
    }
}