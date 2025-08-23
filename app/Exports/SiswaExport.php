<?php

namespace App\Exports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SiswaExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return new Collection();
    }

    public function headings(): array
    {
        return [
            'nama_lengkap',
            'username',
            'password',
            'nis',
            'kelas',
        ];
    }
}