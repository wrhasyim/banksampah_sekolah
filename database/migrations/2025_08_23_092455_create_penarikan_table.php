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
        Schema::create('penarikan', function (Blueprint $table) {
    $table->id(); // Primary Key
    $table->foreignId('id_siswa')->constrained('siswa')->onDelete('cascade');
    $table->decimal('jumlah_penarikan', 10, 2);
    $table->foreignId('id_admin')->constrained('pengguna');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('penarikan');
    }
};
