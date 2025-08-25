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
            ['nama_kelas' => 'Kelas 1A', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas 1B', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas 2A', 'created_at' => now(), 'updated_at' => now()],
        ]);

        JenisSampah::insert([
            ['nama_sampah' => 'Botol Plastik', 'harga_per_satuan' => 500, 'stok' => 0],
            ['nama_sampah' => 'Kardus', 'harga_per_satuan' => 1000, 'stok' => 0],
        ]);
    }
}