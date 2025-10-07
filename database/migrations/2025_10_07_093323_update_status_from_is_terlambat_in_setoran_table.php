<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Update semua baris yang 'is_terlambat' nya true,
        // atur statusnya menjadi 'terlambat'
        DB::table('setoran')
            ->where('is_terlambat', true)
            ->update(['status' => 'terlambat']);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Jika di-rollback, kembalikan status 'terlambat' menjadi 'normal'
        // (Tidak mengembalikan data secara sempurna, tapi aman)
        DB::table('setoran')
            ->where('status', 'terlambat')
            ->update(['status' => 'normal']);
    }
};