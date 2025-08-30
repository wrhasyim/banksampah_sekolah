<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penarikan extends Model
{
    use HasFactory;
    protected $table = 'penarikan';

    // --- PERBAIKAN FINAL DI SINI ---
    protected $fillable = [
        'siswa_id',
        'id_kelas',
        'jumlah_penarikan',
        'tanggal_penarikan',
    ];

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'siswa_id');
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    // Relasi ke admin bisa kita hapus karena tidak ada kolomnya
    // public function admin()
    // {
    //     return $this->belongsTo(Pengguna::class, 'id_admin');
    // }
}