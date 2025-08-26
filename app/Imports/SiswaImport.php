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
use Illuminate\Support\Facades\DB;

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting, ShouldQueue, WithChunkReading
{
    use Importable;
    private $kelasCollection;

    // Constructor untuk mengambil semua data kelas satu kali saja di awal.
    public function __construct()
    {
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    public function model(array $row)
    {
        // Ambil ID kelas dari "memori" yang sudah kita siapkan, bukan dari database.
        $id_kelas = $this->kelasCollection->get($row['nama_kelas']);

        // Jika kelas tidak ditemukan di "memori", lewati baris ini.
        // (Aturan validasi 'exists' sudah seharusnya menangani ini, tapi ini lapisan pengaman tambahan).
        if (!$id_kelas) {
            return null;
        }
        
        DB::transaction(function () use ($row, $id_kelas) {
            $pengguna = Pengguna::create([
                'nama_lengkap' => $row['nama_lengkap'],
                'username' => $row['username'],
                'password' => Hash::make($row['password']),
                'role' => 'siswa',
            ]);

            Siswa::create([
                'id_pengguna' => $pengguna->id,
                'id_kelas' => $id_kelas,
                'nis' => $row['nis'],
                'saldo' => 0,
            ]);
        });
    }

    public function rules(): array
    {
        return [
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|unique:pengguna,username',
            'password' => 'required',
            'nis' => 'nullable|unique:siswa,nis',
            'nama_kelas' => 'required|exists:kelas,nama_kelas',
        ];
    }
    
    public function columnFormats(): array
    {
        return [
            'B' => NumberFormat::FORMAT_TEXT,
            'C' => NumberFormat::FORMAT_TEXT,
            'D' => NumberFormat::FORMAT_TEXT,
        ];
    }

    public function chunkSize(): int
    {
        return 100;
    }
}