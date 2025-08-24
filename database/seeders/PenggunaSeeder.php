<?php

namespace Database\Seeders;

use App\Models\Pengguna;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class PenggunaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Hapus data pengguna lama jika ada, untuk menghindari duplikat
        Pengguna::truncate();

        // Buat akun admin default
        Pengguna::create([
            'nama_lengkap' => 'Administrator',
            'username' => 'admin',
            'password' => Hash::make('password'), // passwordnya adalah "password"
            'role' => 'admin',
        ]);
    }
}