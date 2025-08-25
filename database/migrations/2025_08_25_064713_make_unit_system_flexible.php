<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Modifikasi tabel jenis_sampah
        Schema::table('jenis_sampah', function (Blueprint $table) {
            // Tambahkan kolom satuan (pcs atau kg)
            $table->string('satuan')->default('pcs')->after('nama_sampah');
            // Ubah stok agar bisa menampung desimal (untuk kg)
            $table->decimal('stok', 8, 2)->default(0)->change();
        });

        // 2. Modifikasi tabel setoran
        Schema::table('setoran', function (Blueprint $table) {
            // Ubah jumlah_satuan menjadi jumlah dan tipe datanya menjadi desimal
            $table->renameColumn('jumlah_satuan', 'jumlah');
            $table->decimal('jumlah', 8, 2)->change();
        });

        // 3. Modifikasi tabel detail_penjualan
        Schema::table('detail_penjualan', function (Blueprint $table) {
            // Ubah jumlah_satuan menjadi jumlah dan tipe datanya menjadi desimal
            $table->renameColumn('jumlah_satuan', 'jumlah');
            $table->decimal('jumlah', 8, 2)->change();
        });
    }

    public function down(): void
    {
        // Logika untuk mengembalikan perubahan jika diperlukan
        Schema::table('jenis_sampah', function (Blueprint $table) {
            $table->dropColumn('satuan');
            $table->integer('stok')->default(0)->change();
        });
        Schema::table('setoran', function (Blueprint $table) {
            $table->renameColumn('jumlah', 'jumlah_satuan');
            $table->integer('jumlah_satuan')->change();
        });
        Schema::table('detail_penjualan', function (Blueprint $table) {
            $table->renameColumn('jumlah', 'jumlah_satuan');
            $table->integer('jumlah_satuan')->change();
        });
    }
};