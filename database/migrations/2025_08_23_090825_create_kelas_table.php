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
        Schema::create('kelas', function (Blueprint $table) {
        $table->id(); // Membuat kolom 'id' (Primary Key, auto-increment)
        $table->string('nama_kelas', 50); // Membuat kolom VARCHAR(50)
        // Laravel otomatis menambahkan kolom 'created_at' dan 'updated_at'
        // Jika tidak butuh, kita bisa hapus nanti. Untuk sekarang, biarkan saja.
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kelas');
    }
};
