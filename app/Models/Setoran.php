<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Setoran extends Model
{
    use HasFactory;

    protected $table = 'setoran';

    // PERBAIKAN: Mengganti 'id_siswa' menjadi 'siswa_id'
    protected $fillable = ['siswa_id', 'jenis_sampah_id', 'jumlah', 'total_harga', 'id_admin', 'status', 'created_at', 'updated_at'];

    public function siswa()
    {
        // PERBAIKAN: Menggunakan 'siswa_id' sebagai foreign key
        return $this->belongsTo(Siswa::class, 'siswa_id');
    }

    public function jenisSampah()
    {
        return $this->belongsTo(JenisSampah::class, 'jenis_sampah_id');
    }

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
    /**
     * Definisikan relasi one-to-one dengan model Insentif.
     */
    public function insentif()
    {
        return $this->hasOne(Insentif::class, 'setoran_id');
    }
}