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
        Schema::table('penarikan', function (Blueprint $table) {
            // Ubah siswa_id agar bisa null
            $table->foreignId('siswa_id')->nullable()->change(); // DIPERBAIKI: 'id_siswa' -> 'siswa_id'
            
            // Tambahkan kolom id_kelas yang bisa null
            $table->foreignId('id_kelas')->nullable()->constrained('kelas')->after('siswa_id'); // DIPERBAIKI: 'id_siswa' -> 'siswa_id'
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('penarikan', function (Blueprint $table) {
            $table->dropForeign(['id_kelas']);
            $table->dropColumn('id_kelas');
            $table->foreignId('siswa_id')->nullable(false)->change(); // DIPERBAIKI: 'id_siswa' -> 'siswa_id'
        });
    }
};