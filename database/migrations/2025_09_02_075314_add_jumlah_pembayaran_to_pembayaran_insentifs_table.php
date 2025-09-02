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
            // Menambahkan kolom untuk jumlah pembayaran
            $table->decimal('jumlah_pembayaran', 15, 2)->after('tanggal_pembayaran');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('pembayaran_insentifs', function (Blueprint $table) {
            $table->dropColumn('jumlah_pembayaran');
        });
    }
};