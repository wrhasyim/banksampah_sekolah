<?php

// --- PERBAIKAN DI SINI ---
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penjualan extends Model
{
    use HasFactory;
    protected $table = 'penjualan';

    protected $fillable = [
        'id_admin', 
        'nama_pengepul', 
        'tanggal_penjualan',
        'total_harga'
    ];

    protected $casts = [
        'tanggal_penjualan' => 'datetime',
    ];

    public function detailPenjualan()
    {
        return $this->hasMany(DetailPenjualan::class, 'id_penjualan');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}