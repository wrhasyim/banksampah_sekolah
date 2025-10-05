// database/migrations/xxxx_xx_xx_xxxxxx_create_rewards_table.php
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
        Schema::create('rewards', function (Blueprint $table) {
            $table->id();
            // Relasi ke user/pengguna yang menerima reward
            $table->foreignId('user_id')->constrained('pengguna')->onDelete('cascade');
            
            // Kolom utama untuk reward
            $table->integer('quantity'); // Jumlah botol
            $table->string('item_name')->default('botol'); // Nama item
            $table->text('description')->nullable(); // Keterangan/alasan reward (opsional)

            // Kolom untuk pencatatan biaya
            $table->unsignedInteger('price_per_item_at_reward'); // Harga per item saat reward diberikan
            $table->unsignedBigInteger('total_operational_cost'); // Total biaya (quantity * price)
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rewards');
    }
};