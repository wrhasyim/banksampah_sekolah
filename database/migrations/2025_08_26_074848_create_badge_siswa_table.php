<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::create('badge_siswa', function (Blueprint $table) {
        $table->id();
        $table->foreignId('siswa_id')->constrained('siswa')->onDelete('cascade');
        $table->foreignId('badge_id')->constrained()->onDelete('cascade');
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('badge_siswa');
    }
};
