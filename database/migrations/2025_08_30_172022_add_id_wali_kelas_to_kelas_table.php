<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            // Menambahkan kolom id_wali_kelas setelah nama_kelas
            // Kolom ini bisa null dan terhubung ke tabel pengguna
            $table->foreignId('id_wali_kelas')->nullable()->constrained('pengguna')->after('nama_kelas');
        });
    }

    public function down(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            // Menghapus foreign key constraint terlebih dahulu
            $table->dropForeign(['id_wali_kelas']);
            // Menghapus kolomnya
            $table->dropColumn('id_wali_kelas');
        });
    }
};