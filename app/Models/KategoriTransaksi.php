<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KategoriTransaksi extends Model
{
    use HasFactory;
    protected $table = 'kategori_transaksi';
    protected $fillable = ['nama_kategori', 'tipe'];

    /**
     * Definisikan relasi one-to-many ke model BukuKas.
     */
    public function bukuKas()
    {
        return $this->hasMany(BukuKas::class, 'id_kategori');
    }
}