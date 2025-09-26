<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Setoran extends Model
{
    use HasFactory;

    protected $table = 'setoran';

    /**
     * PERBAIKAN FINAL:
     * - Menambahkan 'is_terlambat' ke fillable.
     * - Menghapus 'created_at' & 'updated_at' karena dikelola otomatis.
     * - Memastikan semua nama kolom sesuai standar (snake_case).
     */
    protected $fillable = [
        'siswa_id',
        'jenis_sampah_id',
        'jumlah',
        'total_harga',
        'status',
        'is_terlambat', // <-- Ini yang menyebabkan data terlambat tidak masuk
    ];

    /**
     * Casting untuk memastikan 'is_terlambat' selalu bertipe boolean.
     */
    protected $casts = [
        'is_terlambat' => 'boolean',
    ];

    public function siswa()
    {
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

    public function insentif()
    {
        return $this->hasOne(Insentif::class, 'setoran_id');
    }
}