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
        Schema::create('jenis_sampah', function (Blueprint $table) {
        $table->id(); // Primary Key
        $table->string('nama_sampah', 50);
        $table->decimal('harga_per_satuan', 10, 2); // Harga per pcs/satuan
        $table->timestamps(); // Kolom created_at dan updated_at
          });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jenis_sampah');
    }
};
