<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Penjualan extends Model
{
    use HasFactory;

    /**
     * Nama tabel yang terhubung dengan model.
     *
     * @var string
     */
    protected $table = 'penjualan';

    /**
     * Kolom yang dapat diisi secara massal.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'id_admin',
        'nama_pengepul',
        'tanggal_penjualan',
        'total_harga'
    ];

    /**
     * Tipe data asli untuk atribut model.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'tanggal_penjualan' => 'datetime',
    ];

    /**
     * Mendefinisikan relasi one-to-many ke model DetailPenjualan.
     *
     * Nama method diubah menjadi 'detailPenjualans' (plural) untuk mengikuti
     * konvensi Laravel dan memperbaiki error RelationNotFoundException.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function detailPenjualans(): HasMany
    {
        return $this->hasMany(DetailPenjualan::class, 'id_penjualan');
    }

    /**
     * Mendefinisikan relasi belongsTo ke model Pengguna (admin).
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function admin(): BelongsTo
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}