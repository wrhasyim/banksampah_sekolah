<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Tabel utama untuk transaksi penjualan
        Schema::create('penjualan', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_admin')->constrained('pengguna');
            $table->string('nama_pengepul');
            $table->decimal('total_harga', 10, 2);
            $table->timestamps();
        });

        // Tabel untuk detail item yang terjual dalam satu transaksi
        Schema::create('detail_penjualan', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_penjualan')->constrained('penjualan')->onDelete('cascade');
            $table->foreignId('id_jenis_sampah')->constrained('jenis_sampah');
            $table->integer('jumlah');
            $table->decimal('subtotal_harga', 10, 2);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('detail_penjualan');
        Schema::dropIfExists('penjualan');
    }
};