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
        // 'nama_jenis' adalah kolom yang salah
        $table->enum('status', ['aktif', 'tidak aktif'])->default('aktif')->after('nama_sampah');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('jenis_sampah', function (Blueprint $table) {
            //
        });
    }
};
