<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes; // Impor SoftDeletes

class BukuKas extends Model
{
    use HasFactory, SoftDeletes; // Gunakan SoftDeletes

    protected $table = 'buku_kas';
    protected $fillable = [
        'tanggal', 
        'deskripsi', 
        'tipe', 
        'jumlah', 
        'id_admin',
        'id_kategori' // Tambahkan id_kategori
    ];

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }

    // Relasi baru ke KategoriTransaksi
    public function kategori()
    {
        return $this->belongsTo(KategoriTransaksi::class, 'id_kategori');
    }
}