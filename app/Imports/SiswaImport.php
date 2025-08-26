<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Validators\Failure;
use Maatwebsite\Excel\Concerns\SkipsFailures;

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting, WithChunkReading, SkipsOnFailure
{
    use Importable, SkipsFailures;

    private $kelasCollection;

    public function __construct()
    {
        // Ambil semua data kelas sekali saja di awal
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    public function model(array $row)
    {
        // Cari id kelas berdasarkan nama
        $idKelas = $this->kelasCollection->get($row['nama_kelas']) ?? null;

        // Jika kelas tidak ditemukan, lewati baris
        if (!$idKelas) {
            return null;
        }

        // Buat pengguna (jika belum ada)
        $pengguna = Pengguna::firstOrCreate(
            ['username' => $row['username']],
            [
                'nama_lengkap' => $row['nama_lengkap'],
                'password'     => Hash::make($row['password'] ?? '12345678'),
                'role'         => 'siswa',
            ]
        );

        // Buat siswa (jika belum ada)
        return Siswa::firstOrCreate(
            ['nis' => $row['nis']],
            [
                'id_pengguna' => $pengguna->id,
                'id_kelas'    => $idKelas,
                'saldo'       => 0,
            ]
        );
    }

    public function rules(): array
    {
        return [
            '*.nama_lengkap' => 'required|string|max:255',
            '*.username'     => 'required|string',
            '*.password'     => 'nullable|string',
            '*.nis'          => 'nullable|string|max:50',
            '*.nama_kelas'   => 'required|string',
        ];
    }

    public function columnFormats(): array
    {
        return [
            'B' => NumberFormat::FORMAT_TEXT, // username
            'C' => NumberFormat::FORMAT_TEXT, // password
            'D' => NumberFormat::FORMAT_TEXT, // nis
        ];
    }

    public function chunkSize(): int
    {
        return 100; // Proses 100 baris per batch
    }
}
