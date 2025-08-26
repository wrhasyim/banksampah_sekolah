<?php

namespace Database\Seeders;

use App\Models\Kelas;
use App\Models\JenisSampah;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema; // <-- Tambahkan ini

class MasterDataSeeder extends Seeder
{
    public function run(): void
    {
        // Nonaktifkan pengecekan, kosongkan tabel, lalu aktifkan kembali
        Schema::disableForeignKeyConstraints();
        Kelas::truncate();
        JenisSampah::truncate();
        Schema::enableForeignKeyConstraints();

        Kelas::insert([
            ['nama_kelas' => 'X MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'X TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XI TM 7', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'XII TM 7', 'created_at' => now(), 'updated_at' => now()],
        ]);

        JenisSampah::insert([
            ['nama_sampah' => 'Botol Plastik', 'harga_per_satuan' => 35, 'stok' => 0],
            ['nama_sampah' => 'Gelas Plastik', 'harga_per_satuan' => 20, 'stok' => 0],
        ]);
    }
}