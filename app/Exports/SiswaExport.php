<?php

namespace App\Exports;

use App\Models\Siswa;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class SiswaExport implements FromCollection, WithHeadings, WithMapping
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        // Ambil semua data siswa beserta relasi yang dibutuhkan
        return Siswa::with(['pengguna', 'kelas'])->get();
    }

    /**
     * Tentukan header untuk file Excel.
     */
    public function headings(): array
    {
        return [
            'Nama Lengkap',
            'Username',
            'NIS',
            'Kelas',
            'Saldo (Rp)',
        ];
    }

    /**
     * Petakan data dari setiap siswa ke kolom yang sesuai.
     *
     * @param mixed $siswa
     * @return array
     */
    public function map($siswa): array
    {
        return [
            $siswa->pengguna?->nama_lengkap ?? 'N/A',
            $siswa->pengguna?->username ?? 'N/A',
            $siswa->nis,
            $siswa->kelas?->nama_kelas ?? 'N/A',
            $siswa->saldo,
        ];
    }
}