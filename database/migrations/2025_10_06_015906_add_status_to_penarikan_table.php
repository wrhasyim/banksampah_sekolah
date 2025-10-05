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
        Schema::table('penarikan', function (Blueprint $table) {
            // Tambahkan kolom status setelah 'jumlah_penarikan'
            $table->string('status')->default('pending')->after('jumlah_penarikan');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('penarikan', function (Blueprint $table) {
            $table->dropColumn('status');
        });
    }
};