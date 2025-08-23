<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Setoran extends Model
{
    use HasFactory;

    protected $table = 'setoran';
    protected $fillable = [
        'id_siswa',
        'id_jenis_sampah',
        'id_admin',
        'jumlah_satuan',
        'tanggal_setoran',
        'total_harga',
    ];

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'id_siswa');
    }

    public function jenis_sampah()
    {
        return $this->belongsTo(JenisSampah::class, 'id_jenis_sampah');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}