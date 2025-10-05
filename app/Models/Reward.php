<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Reward extends Model
{
    use HasFactory;

    /**
     * Atribut yang diizinkan untuk diisi secara massal (mass assignable).
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'quantity',
        'item_name',
        'description',
        'price_per_item_at_reward',
        'total_operational_cost',
    ];

    /**
     * Mendefinisikan relasi "belongsTo" ke model Pengguna.
     * Setiap record reward dimiliki oleh satu pengguna.
     */
    public function pengguna(): BelongsTo
    {
        return $this->belongsTo(Pengguna::class, 'user_id');
    }
}