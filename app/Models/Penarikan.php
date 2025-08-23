<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penarikan extends Model
{
    use HasFactory;
    
    protected $table = 'penarikan';
    protected $fillable = ['id_siswa', 'jumlah_penarikan', 'id_admin'];

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'id_siswa');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}