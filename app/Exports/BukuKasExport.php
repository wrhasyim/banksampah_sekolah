<?php

namespace App\Exports;

use App\Models\BukuKas;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Carbon\Carbon;

class BukuKasExport implements FromCollection, WithHeadings, WithMapping
{
    protected $startDate;
    protected $endDate;

    public function __construct($startDate, $endDate)
    {
        $this->startDate = $startDate;
        $this->endDate = $endDate;
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $query = BukuKas::with('kategori')->latest('tanggal');

        if ($this->startDate && $this->endDate) {
            $query->whereBetween('tanggal', [$this->startDate, $this->endDate]);
        }

        return $query->get();
    }

    /**
     * @return array
     */
    public function headings(): array
    {
        return [
            'Tanggal',
            'Deskripsi',
            'Kategori',
            'Tipe',
            'Pemasukan (Rp)',
            'Pengeluaran (Rp)',
        ];
    }

    /**
     * @param mixed $transaksi
     *
     * @return array
     */
    public function map($transaksi): array
    {
        return [
            Carbon::parse($transaksi->tanggal)->format('d-m-Y'),
            $transaksi->deskripsi,
            $transaksi->kategori->nama_kategori ?? '-',
            ucfirst($transaksi->tipe),
            $transaksi->tipe == 'pemasukan' ? $transaksi->jumlah : 0,
            $transaksi->tipe == 'pengeluaran' ? $transaksi->jumlah : 0,
        ];
    }
}