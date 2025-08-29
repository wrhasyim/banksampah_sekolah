<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'siswa';

    protected $fillable = [
        'id_pengguna',
        'id_kelas',
        'nis',
        'saldo',
        'points', // tambahkan points jika belum ada
    ];

    /**
     * Get the user that owns the Siswa.
     */
    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_pengguna');
    }

    /**
     * Get the kelas for the siswa.
     */
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    /**
     * Get the setoran for the siswa.
     */
    public function setoran()
    {
        return $this->hasMany(Setoran::class, 'siswa_id');
    }

    /**
     * Get the penarikan for the siswa.
     */
    public function penarikan()
    {
        return $this->hasMany(Penarikan::class, 'siswa_id');
    }

    /**
     * The badges that belong to the Siswa.
     */
    public function badges()
    {
        return $this->belongsToMany(Badge::class, 'badge_siswa');
    }
}