<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kelas extends Model
{
    use HasFactory;
    protected $table = 'kelas';
    protected $fillable = ['nama_kelas', 'id_wali_kelas'];

    public function siswa()
    {
        return $this->hasMany(Siswa::class, 'id_kelas');
    }

    public function waliKelas()
    {
        return $this->belongsTo(Pengguna::class, 'id_wali_kelas');
    }

    // --- TAMBAHKAN FUNGSI RELASI INI ---
    public function setoran()
    {
        // Relasi ini mengambil semua 'setoran' melalui model 'siswa'
        return $this->hasManyThrough(Setoran::class, Siswa::class, 'id_kelas', 'siswa_id', 'id', 'id');
    }
}