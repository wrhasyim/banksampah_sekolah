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
            ['nama_kelas' => 'Kelas X MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas X TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XI TM 7', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII MPLB 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII MPLB 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 1', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 2', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 3', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 4', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 5', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 6', 'created_at' => now(), 'updated_at' => now()],
            ['nama_kelas' => 'Kelas XII TM 7', 'created_at' => now(), 'updated_at' => now()],
        ]);

        JenisSampah::insert([
            ['nama_sampah' => 'Botol Plastik', 'harga_per_satuan' => 35, 'stok' => 0],
            ['nama_sampah' => 'Gelas Plastik', 'harga_per_satuan' => 20, 'stok' => 0],
        ]);
    }
}