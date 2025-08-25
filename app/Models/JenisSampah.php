<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisSampah extends Model
{
    use HasFactory;
    
    protected $table = 'jenis_sampah';
    protected $fillable = ['nama_sampah', 'satuan', 'harga_per_satuan', 'stok'];

    /**
     * Relasi ke DetailPenjualan: Satu Jenis Sampah bisa ada di banyak detail penjualan.
     */
    public function detailPenjualan()
    {
        return $this->hasMany(DetailPenjualan::class, 'id_jenis_sampah');
    }

    /**
     * Relasi ke Setoran: Satu Jenis Sampah bisa ada di banyak setoran.
     */
    public function setoran()
    {
        return $this->hasMany(Setoran::class, 'id_jenis_sampah');
    }
}