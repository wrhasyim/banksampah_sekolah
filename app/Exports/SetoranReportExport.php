<?php

namespace App\Exports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SetoranReportExport implements FromCollection, WithHeadings
{
    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function collection()
    {
        return $this->data->map(function ($item) {
            return [
                'Tanggal' => $item->created_at->format('d-m-Y H:i'),
                'Nama Siswa' => $item->siswa->pengguna->nama_lengkap,
                'Kelas' => $item->siswa->kelas->nama_kelas,
                'Jenis Sampah' => $item->jenis_sampah->nama_sampah,
                'Jumlah' => $item->jumlah_satuan,
                'Total Harga' => $item->total_harga,
                'Admin Pencatat' => $item->admin->nama_lengkap,
            ];
        });
    }

    public function headings(): array
    {
        return [
            'Tanggal',
            'Nama Siswa',
            'Kelas',
            'Jenis Sampah',
            'Jumlah',
            'Total Harga',
            'Admin Pencatat',
        ];
    }
}