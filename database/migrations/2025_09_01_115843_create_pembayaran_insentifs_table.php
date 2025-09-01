<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pembayaran_insentifs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_admin')->constrained('pengguna');
            $table->date('tanggal_pembayaran');
            $table->decimal('total_dibayar', 15, 2);
            $table->text('keterangan')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pembayaran_insentifs');
    }
};