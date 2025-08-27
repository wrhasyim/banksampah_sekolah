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
        Schema::table('penjualan', function (Blueprint $table) {
            // Periksa apakah kolom 'total_penjualan' ada, jika ada, ubah namanya menjadi 'total'
            if (Schema::hasColumn('penjualan', 'total_penjualan')) {
                $table->renameColumn('total_penjualan', 'total');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('penjualan', function (Blueprint $table) {
            // Jika perlu dibatalkan, ubah kembali namanya
            if (Schema::hasColumn('penjualan', 'total')) {
                $table->renameColumn('total', 'total_penjualan');
            }
        });
    }
};