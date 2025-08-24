<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class PenjualanReportExport implements FromCollection, WithHeadings, WithMapping
{
    protected $penjualan;

    public function __construct($penjualan)
    {
        $this->penjualan = $penjualan;
    }

    public function collection()
    {
        return $this->penjualan;
    }

    public function headings(): array
    {
        return [
            'ID Transaksi',
            'Tanggal',
            'Nama Pengepul',
            'Total Harga',
            'Admin Pencatat',
        ];
    }

    public function map($item): array
    {
        return [
            $item->id,
            $item->created_at->format('d-m-Y H:i'),
            $item->nama_pengepul,
            $item->total_harga,
            $item->admin->nama_lengkap,
        ];
    }
}