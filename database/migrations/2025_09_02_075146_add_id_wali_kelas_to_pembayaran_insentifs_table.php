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
        Schema::table('pembayaran_insentifs', function (Blueprint $table) {
            // Menambahkan kolom id_wali_kelas setelah id_admin
            $table->foreignId('id_wali_kelas')->nullable()->constrained('pengguna')->after('id_admin');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('pembayaran_insentifs', function (Blueprint $table) {
            // Menghapus foreign key constraint terlebih dahulu
            $table->dropForeign(['id_wali_kelas']);
            // Menghapus kolom
            $table->dropColumn('id_wali_kelas');
        });
    }
};