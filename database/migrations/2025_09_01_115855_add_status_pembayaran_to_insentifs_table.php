<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('insentifs', function (Blueprint $table) {
            $table->string('status_pembayaran')->default('belum dibayar')->after('jumlah_insentif');
            $table->foreignId('pembayaran_insentif_id')->nullable()->constrained('pembayaran_insentifs')->after('status_pembayaran');
        });
    }

    public function down(): void
    {
        Schema::table('insentifs', function (Blueprint $table) {
            $table->dropForeign(['pembayaran_insentif_id']);
            $table->dropColumn(['status_pembayaran', 'pembayaran_insentif_id']);
        });
    }
};