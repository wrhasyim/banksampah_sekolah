<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'siswa';
    protected $fillable = ['id_pengguna', 'id_kelas', 'nis', 'saldo'];

    /**
     * Relasi ke Pengguna: Siswa adalah bagian dari satu Pengguna
     */
    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_pengguna');
    }

    /**
     * Relasi ke Kelas: Siswa berada di satu Kelas
     */
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    /**
     * Relasi ke Setoran: Satu Siswa bisa memiliki banyak Setoran
     */
    public function setoran()
    {
        return $this->hasMany(Setoran::class, 'id_siswa');
    }

    /**
     * Relasi ke Penarikan: Satu Siswa bisa memiliki banyak Penarikan
     */
    public function penarikan()
    {
        return $this->hasMany(Penarikan::class, 'id_siswa');
    }
}