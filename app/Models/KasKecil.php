<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KasKecil extends Model
{
    use HasFactory;

    protected $table = 'kas_kecil';
    protected $fillable = ['tanggal', 'deskripsi', 'tipe', 'jumlah', 'id_admin'];

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}