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
            // Menambahkan kolom stok setelah harga_per_satuan
            // Default 0 artinya setiap sampah baru stok awalnya adalah nol.
            $table->integer('stok')->default(0)->after('harga_per_satuan');
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
