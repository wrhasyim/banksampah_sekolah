<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Setoran extends Model
{
    use HasFactory;

    protected $table = 'setoran';

    // PERBAIKAN: Mengganti 'id_siswa' menjadi 'siswa_id'
    protected $fillable = ['siswa_id', 'id_jenis_sampah', 'jumlah', 'total_harga', 'id_admin'];

    public function siswa()
    {
        // PERBAIKAN: Menggunakan 'siswa_id' sebagai foreign key
        return $this->belongsTo(Siswa::class, 'siswa_id');
    }

    public function jenisSampah()
    {
        return $this->belongsTo(JenisSampah::class, 'id_jenis_sampah');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}