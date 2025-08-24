<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\WithHeadings;

class SetoranSampleExport implements WithHeadings
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function headings(): array
    {
        return [
            'nis_siswa',
            'kode_sampah',
            'jumlah_satuan',
        ];
    }
}