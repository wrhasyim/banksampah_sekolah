<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('kategori_transaksi', function (Blueprint $table) {
            $table->id();
            $table->string('nama_kategori');
            $table->enum('tipe', ['pemasukan', 'pengeluaran']);
            $table->timestamps();
        });

        Schema::table('buku_kas', function (Blueprint $table) {
            $table->foreignId('id_kategori')->nullable()->constrained('kategori_transaksi')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('buku_kas', function (Blueprint $table) {
            $table->dropForeign(['id_kategori']);
            $table->dropColumn('id_kategori');
        });
        Schema::dropIfExists('kategori_transaksi');
    }
};