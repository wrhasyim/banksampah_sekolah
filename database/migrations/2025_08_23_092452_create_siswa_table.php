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
        Schema::create('siswa', function (Blueprint $table) {
    $table->id(); // Primary Key
    $table->foreignId('id_pengguna')->constrained('pengguna')->onDelete('cascade');
    $table->foreignId('id_kelas')->constrained('kelas')->onDelete('cascade');
    $table->string('nis', 20)->unique()->nullable(); // NIS, boleh kosong
    $table->decimal('saldo', 10, 2)->default(0); // Saldo awal adalah 0
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siswa');
    }
};
