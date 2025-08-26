<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Validators\Failure;
use Maatwebsite\Excel\Concerns\SkipsFailures;
use Illuminate\Support\Str;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

class SiswaImport implements ToModel, WithHeadingRow, WithValidation, WithColumnFormatting, WithChunkReading, SkipsOnFailure
{
    use Importable, SkipsFailures;

    private $kelasCollection;

    public function __construct()
    {
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        // Cari id kelas berdasarkan nama.
        $idKelas = $this->kelasCollection->get($row['nama_kelas']);

        // Jika kelas tidak ditemukan, kembalikan null agar baris dilewati.
        if (is_null($idKelas)) {
            return null;
        }

        // Mulai transaksi database untuk setiap baris
        DB::beginTransaction();

        try {
            // Cek apakah username sudah ada
            $pengguna = Pengguna::firstOrNew(['username' => $row['username']]);
            
            // Jika pengguna baru, buat data pengguna
            if (!$pengguna->exists) {
                $pengguna->nama_lengkap = $row['nama_lengkap'];
                $pengguna->password     = Hash::make($row['password'] ?? Str::random(10));
                $pengguna->role         = 'siswa';
                $pengguna->save();
            }

            // Cek apakah NIS sudah ada
            $siswa = Siswa::firstOrNew(['nis' => $row['nis']]);
            
            // Jika NIS baru, buat data siswa
            if (!$siswa->exists) {
                $siswa->id_pengguna = $pengguna->id;
                $siswa->id_kelas    = $idKelas;
                $siswa->saldo       = 0;
                $siswa->save();
            }
            DB::commit();
            return $siswa;

        } catch (\Exception $e) {
            DB::rollback();
            // Lanjutkan impor tanpa menghentikan proses
            // Pesan kegagalan akan ditangkap oleh SkipsOnFailure
            return null;
        }
    }

    public function rules(): array
    {
        return [
            '*.nama_lengkap' => 'required|string|max:255',
            '*.username'     => 'required|string|unique:pengguna,username|max:50',
            '*.password'     => 'nullable|string',
            '*.nis'          => 'nullable|string|max:20|unique:siswa,nis',
            '*.nama_kelas'   => 'required|string|exists:kelas,nama_kelas',
        ];
    }
    
    public function customValidationMessages()
    {
        return [
            '*.username.unique' => 'Username :attribute di baris :row sudah ada.',
            '*.nis.unique' => 'NIS :attribute di baris :row sudah ada.',
            '*.nama_kelas.exists' => 'Kelas ":input" di baris :row tidak ditemukan.'
        ];
    }

    public function columnFormats(): array
    {
        return [
            'B' => NumberFormat::FORMAT_TEXT,
            'D' => NumberFormat::FORMAT_TEXT,
        ];
    }

    public function chunkSize(): int
    {
        return 100;
    }
}