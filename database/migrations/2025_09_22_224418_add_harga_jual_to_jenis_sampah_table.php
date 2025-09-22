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
            // Menambahkan kolom harga_jual setelah harga_per_satuan
            // Harga_per_satuan kita anggap sebagai harga beli dari siswa
            $table->decimal('harga_jual', 10, 2)->after('harga_per_satuan')->default(0)->comment('Harga jual ke pengepul');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('jenis_sampah', function (Blueprint $table) {
            $table->dropColumn('harga_jual');
        });
    }
};