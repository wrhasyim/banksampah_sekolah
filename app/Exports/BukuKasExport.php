<?php

namespace App\Exports;

use App\Models\BukuKas;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class BukuKasExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize
{
    protected $bulan;

    // --- PERBAIKAN DI SINI ---
    // Hapus parameter $saldoAkhir yang tidak digunakan
    public function __construct($bulan)
    {
        $this->bulan = $bulan;
    }

    public function collection()
    {
        $startDate = Carbon::createFromFormat('Y-m', $this->bulan)->startOfMonth();
        $endDate = Carbon::createFromFormat('Y-m', $this->bulan)->endOfMonth();

        return BukuKas::whereBetween('tanggal', [$startDate, $endDate])
            ->orderBy('tanggal', 'asc')
            ->get();
    }

    public function headings(): array
    {
        return [
            'Tanggal',
            'Keterangan',
            'Pemasukan',
            'Pengeluaran',
        ];
    }

    public function map($transaksi): array
    {
        return [
            Carbon::parse($transaksi->tanggal)->format('d-m-Y'),
            $transaksi->deskripsi,
            $transaksi->tipe == 'pemasukan' ? $transaksi->jumlah : 0,
            $transaksi->tipe == 'pengeluaran' ? $transaksi->jumlah : 0,
        ];
    }
}