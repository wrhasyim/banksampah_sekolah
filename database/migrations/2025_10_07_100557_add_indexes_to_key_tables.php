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
        Schema::table('setoran', function (Blueprint $table) {
            $table->index('siswa_id');
            $table->index('status');
            $table->index('created_at');
        });

        Schema::table('penarikan', function (Blueprint $table) {
            $table->index('siswa_id');
            $table->index('status');
        });

        Schema::table('siswa', function (Blueprint $table) {
            $table->index('id_kelas');
            $table->index('id_pengguna');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('setoran', function (Blueprint $table) {
            $table->dropIndex(['siswa_id']);
            $table->dropIndex(['status']);
            $table->dropIndex(['created_at']);
        });

        Schema::table('penarikan', function (Blueprint $table) {
            $table->dropIndex(['siswa_id']);
            $table->dropIndex(['status']);
        });

        Schema::table('siswa', function (Blueprint $table) {
            $table->dropIndex(['id_kelas']);
            $table->dropIndex(['id_pengguna']);
        });
    }
};