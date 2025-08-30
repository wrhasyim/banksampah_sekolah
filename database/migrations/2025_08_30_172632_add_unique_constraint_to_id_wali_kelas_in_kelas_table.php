<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            // Menambahkan unique constraint ke kolom id_wali_kelas
            // Ini akan mencegah id yang sama dimasukkan lebih dari sekali
            $table->unique('id_wali_kelas');
        });
    }

    public function down(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            // Menghapus unique constraint jika migrasi di-rollback
            $table->dropUnique(['id_wali_kelas']);
        });
    }
};