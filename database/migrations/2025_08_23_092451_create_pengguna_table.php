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
        Schema::create('pengguna', function (Blueprint $table) {
    $table->id(); // Primary Key
    $table->string('nama_lengkap', 100);
    $table->string('username', 50)->unique(); // username harus unik
    $table->string('password'); // Nanti akan kita hash
    $table->enum('role', ['admin', 'siswa']); // Hanya boleh diisi 'admin' atau 'siswa'
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pengguna');
    }
};
