<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('saldo_bulanan', function (Blueprint $table) {
            $table->id();
            $table->date('periode'); // Misal: 2025-09-01, untuk menandai periode September 2025
            $table->decimal('saldo_awal', 15, 2)->default(0);
            $table->decimal('total_pemasukan', 15, 2)->default(0);
            $table->decimal('total_pengeluaran', 15, 2)->default(0);
            $table->decimal('saldo_akhir', 15, 2)->default(0);
            $table->timestamp('ditutup_pada');
            $table->foreignId('ditutup_oleh')->constrained('pengguna');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('saldo_bulanan');
    }
};