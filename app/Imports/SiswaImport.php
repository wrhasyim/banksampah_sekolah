<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Support\Str;

class SiswaImport implements ToModel, WithHeadingRow, WithChunkReading
{
    private $kelasCollection;

    public function __construct()
    {
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    public function model(array $row)
    {
        $namaLengkap = (string) ($row['nama_lengkap'] ?? '');
        $username = (string) ($row['username'] ?? '');
        $password = (string) ($row['password'] ?? Str::random(10));
        $nis = (string) ($row['nis'] ?? null);
        $namaKelas = (string) ($row['nama_kelas'] ?? '');

        if (empty($namaLengkap) || empty($username) || empty($namaKelas)) {
            return null; // Lewati baris kosong
        }

        $idKelas = $this->kelasCollection->get($namaKelas);

        if (is_null($idKelas)) {
            return null; // Lewati jika kelas tidak ditemukan
        }
        
        DB::transaction(function () use ($namaLengkap, $username, $password, $nis, $idKelas) {
            // Gunakan firstOrCreate untuk Pengguna berdasarkan username
            $pengguna = Pengguna::firstOrCreate(
                ['username' => $username],
                [
                    'nama_lengkap' => $namaLengkap,
                    'password' => Hash::make($password),
                    'role' => 'siswa',
                ]
            );

            // Gunakan firstOrCreate untuk Siswa berdasarkan id_pengguna atau NIS
            Siswa::firstOrCreate(
                ['id_pengguna' => $pengguna->id],
                [
                    'nis' => $nis,
                    'id_kelas' => $idKelas,
                    'saldo' => 0,
                ]
            );
        });

        return null;
    }

    public function chunkSize(): int
    {
        return 100; // Proses 100 baris sekali jalan
    }
    
    public function rules(): array
    {
        return [
            '*.nama_lengkap' => 'required',
            '*.username' => 'required',
            '*.nama_kelas' => 'required',
        ];
    }
}