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
        // Header baru sesuai permintaan
        return [
            'nama_siswa',
            'nama_kelas',
            'nama_sampah',
            'jumlah_satuan',
        ];
    }
}