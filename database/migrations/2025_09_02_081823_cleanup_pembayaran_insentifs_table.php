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
            // Cek apakah kolom yang salah ('jumlah_pembayaran') ada
            if (Schema::hasColumn('pembayaran_insentifs', 'jumlah_pembayaran')) {
                // Hapus kolom yang salah tersebut
                $table->dropColumn('jumlah_pembayaran');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('pembayaran_insentifs', function (Blueprint $table) {
            // Jika diperlukan, kita bisa membuat ulang kolomnya di sini saat rollback
            // Tapi untuk kasus ini, bisa kita kosongkan saja
        });
    }
};