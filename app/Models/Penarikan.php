<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penarikan extends Model
{
    use HasFactory;
    
    protected $table = 'penarikan';
    // Tambahkan id_kelas
    protected $fillable = ['id_siswa', 'id_kelas', 'jumlah_penarikan', 'id_admin'];

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'id_siswa');
    }
    
    // Tambahkan relasi ke kelas
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}