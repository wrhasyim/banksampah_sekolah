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
use Illuminate\Contracts\Queue\ShouldQueue;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Validators\Failure;
use Maatwebsite\Excel\Concerns\SkipsFailures;

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting, ShouldQueue, WithChunkReading, SkipsOnFailure
{
    use Importable, SkipsFailures;
    private $kelasCollection;

    public function __construct()
    {
        // Ambil semua data kelas sekali saja di awal untuk efisiensi
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    public function model(array $row)
    {
        // 1. Buat data pengguna terlebih dahulu
        $pengguna = Pengguna::create([
            'nama_lengkap' => $row['nama_lengkap'],
            'username'     => $row['username'],
            'password'     => Hash::make($row['password']),
            'role'         => 'siswa',
        ]);

        // 2. Siapkan dan kembalikan data siswa baru.
        // Library Maatwebsite/Excel akan otomatis menyimpannya.
        return new Siswa([
            'id_pengguna' => $pengguna->id,
            'id_kelas'    => $this->kelasCollection->get($row['nama_kelas']),
            'nis'         => $row['nis'],
            'saldo'       => 0,
        ]);
    }

    public function rules(): array
    {
        return [
            'nama_lengkap'          => 'required|string|max:255',
            'username'              => 'required|unique:pengguna,username',
            'password'              => 'required',
            'nis'                   => 'nullable|unique:siswa,nis',
            'nama_kelas'            => 'required|exists:kelas,nama_kelas',
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