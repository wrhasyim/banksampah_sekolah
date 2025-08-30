<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penjualan extends Model
{
    use HasFactory;
    protected $table = 'penjualan';
    
    // --- PERBAIKAN DI SINI ---
    protected $fillable = [
        'id_admin', 
        'nama_pengepul', 
        'tanggal_penjualan', // Tambahkan ini
        'total_harga'
    ];

    public function detailPenjualan() // Mengubah nama metode agar sesuai dengan relasi
    {
        return $this->hasMany(DetailPenjualan::class, 'id_penjualan');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}