<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\WithHeadings;

class SetoranSampleExport implements WithHeadings
{
    /**
    * @return array
    */
    public function headings(): array
    {
        // Ganti 'jumlah_satuan' menjadi 'jumlah'
        return [
            'nama_siswa',
            'nama_kelas',
            'nama_sampah',
            'jumlah', // <-- INI BAGIAN YANG DIPERBAIKI
        ];
    }
}