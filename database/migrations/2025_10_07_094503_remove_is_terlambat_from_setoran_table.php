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
            // Menghapus kolom 'is_terlambat'
            $table->dropColumn('is_terlambat');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('setoran', function (Blueprint $table) {
            // Jika di-rollback, buat kembali kolom 'is_terlambat'
            $table->boolean('is_terlambat')->default(false);
        });
    }
};