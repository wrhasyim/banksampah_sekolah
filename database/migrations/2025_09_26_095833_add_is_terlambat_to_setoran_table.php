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
        Schema::table('setoran', function (Blueprint $table) {
            // Menambah kolom is_terlambat setelah kolom status
            // Defaultnya adalah false (bukan setoran terlambat)
            $table->boolean('is_terlambat')->default(false)->after('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('setoran', function (Blueprint $table) {
            $table->dropColumn('is_terlambat');
        });
    }
};