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
        // Kolom ini untuk membedakan 'setoran_sampah' atau 'reward'
        $table->string('sumber')->default('setoran_sampah')->after('id');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('setoran', function (Blueprint $table) {
            //
        });
    }
};
