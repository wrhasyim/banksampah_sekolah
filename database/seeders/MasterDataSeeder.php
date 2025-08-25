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
            ['nama_kelas' => 'Kelas XII MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 1', 'created_at' => now(), 'updated_at' => now()],
        ]);

        JenisSampah::insert([
            ['nama_sampah' => 'Botol Plastik', 'harga_per_satuan' => 500, 'stok' => 0],
            ['nama_sampah' => 'Gelas Plastik', 'harga_per_satuan' => 1000, 'stok' => 0],
        ]);
    }
}