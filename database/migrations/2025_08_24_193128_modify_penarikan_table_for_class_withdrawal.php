<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('penarikan', function (Blueprint $table) {
            // Ubah id_siswa agar bisa null
            $table->foreignId('id_siswa')->nullable()->change();
            // Tambahkan kolom id_kelas yang bisa null
            $table->foreignId('id_kelas')->nullable()->constrained('kelas')->after('id_siswa');
        });
    }

    public function down(): void
    {
        Schema::table('penarikan', function (Blueprint $table) {
            $table->dropForeign(['id_kelas']);
            $table->dropColumn('id_kelas');
            $table->foreignId('id_siswa')->nullable(false)->change();
        });
    }
};