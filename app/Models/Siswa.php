<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'siswa';
    protected $primaryKey = 'id';
    protected $fillable = [
        'id_pengguna',
        'id_kelas',
        'nis',
        'saldo',
    ];

    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_pengguna');
    }

    // Hubungan ke model Kelas
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }
}