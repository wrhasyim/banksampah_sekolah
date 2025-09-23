<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('jenis_sampah', function (Blueprint $table) {
            // Menambahkan kolom kategori setelah kolom 'nama_jenis'
            // Default 'Siswa' agar data lama otomatis masuk kategori ini
            $table->string('kategori')->after('nama_sampah')->default('Siswa');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('jenis_sampah', function (Blueprint $table) {
            $table->dropColumn('kategori');
        });
    }
};