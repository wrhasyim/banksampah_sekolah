<?php

namespace App\Exports; // <-- INI BAGIAN YANG DIPERBAIKI

use Maatwebsite\Excel\Concerns\WithHeadings;

class SiswaSampleExport implements WithHeadings
{
    /**
    * @return array
    */
    public function headings(): array
    {
        return [
            'nama_lengkap',
            'username',
            'password',
            'nis',
            'nama_kelas',
        ];
    }
}