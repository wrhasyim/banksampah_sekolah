<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BukuKas extends Model
{
    use HasFactory;
    protected $table = 'buku_kas';
    protected $fillable = ['tanggal', 'deskripsi', 'tipe', 'jumlah', 'id_admin'];

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}