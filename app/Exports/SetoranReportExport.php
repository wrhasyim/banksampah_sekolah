<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class SetoranReportExport implements FromCollection, WithHeadings, WithMapping
{
    protected $setoran;

    public function __construct($setoran)
    {
        $this->setoran = $setoran;
    }

    public function collection()
    {
        return $this->setoran;
    }

    public function headings(): array
    {
        return [
            'Tanggal',
            'Nama Siswa',
            'Kelas',
            'Jenis Sampah',
            'Jumlah (pcs)',
            'Total Harga (Rp)',
            'Admin Pencatat',
        ];
    }

    /**
     * Memetakan data untuk setiap baris di Excel.
     *
     * @param mixed $item
     * @return array
     */
    public function map($item): array
    {
        // --- INI BAGIAN YANG DIPERBAIKI ---
        // Gunakan nullsafe operator (?->) dan null coalescing (??) untuk keamanan
        return [
            'tanggal' => $item->created_at->format('d-m-Y H:i'),
            'nama_siswa' => $item->siswa?->pengguna?->nama_lengkap ?? 'Siswa Dihapus',
            'kelas' => $item->siswa?->kelas?->nama_kelas ?? 'Kelas Dihapus',
            'jenis_sampah' => $item->jenisSampah?->nama_sampah ?? 'Jenis Sampah Dihapus',
            'jumlah_satuan' => $item->jumlah_satuan,
            'total_harga' => $item->total_harga,
            'admin' => $item->admin?->nama_lengkap ?? 'Admin Dihapus',
        ];
    }
}