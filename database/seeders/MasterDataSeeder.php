<?php

namespace Database\Seeders;

use App\Models\Kelas;
use App\Models\JenisSampah;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MasterDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Hapus data lama
        Kelas::truncate();
        JenisSampah::truncate();

        // Buat data kelas awal
        Kelas::insert([
            ['nama_kelas' => 'X MPLB 1'],
            ['nama_kelas' => 'X MPLB 2'],
        ]);

        // Buat data jenis sampah awal
        JenisSampah::insert([
            ['nama_sampah' => 'Botol Plastik', 'harga_per_satuan' => 500, 'stok' => 0],
            ['nama_sampah' => 'Gelas Plastik', 'harga_per_satuan' => 300, 'stok' => 0],
           
        ]);
    }
}