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
        Schema::table('insentifs', function (Blueprint $table) {
            // Hapus foreign key yang lama
            $table->dropForeign(['penjualan_id']);
            // Ubah nama kolom
            $table->renameColumn('penjualan_id', 'setoran_id');
            // Tambahkan foreign key yang baru
            $table->foreign('setoran_id')->references('id')->on('setoran')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('insentifs', function (Blueprint $table) {
            $table->dropForeign(['setoran_id']);
            $table->renameColumn('setoran_id', 'penjualan_id');
            $table->foreign('penjualan_id')->references('id')->on('penjualan')->onDelete('cascade');
        });
    }
};