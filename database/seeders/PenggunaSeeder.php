<?php

namespace Database\Seeders;

use App\Models\Pengguna;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema; // <-- Tambahkan ini

class PenggunaSeeder extends Seeder
{
    public function run(): void
    {
        // Nonaktifkan pengecekan, kosongkan tabel, lalu aktifkan kembali
        Schema::disableForeignKeyConstraints();
        Pengguna::truncate();
        Schema::enableForeignKeyConstraints();

        Pengguna::create([
            'nama_lengkap' => 'Administrator',
            'username' => 'admin',
            'password' => Hash::make('password'),
            'role' => 'admin',
        ]);
    }
}