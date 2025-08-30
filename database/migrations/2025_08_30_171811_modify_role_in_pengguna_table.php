<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('pengguna', function (Blueprint $table) {
            // Mengubah kolom 'role' untuk menambahkan 'wali'
            $table->enum('role', ['admin', 'siswa', 'wali'])->change();
        });
    }

    public function down(): void
    {
        Schema::table('pengguna', function (Blueprint $table) {
            // Mengembalikan ke kondisi semula jika migrasi di-rollback
            $table->enum('role', ['admin', 'siswa'])->change();
        });
    }
};