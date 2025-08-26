<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB; // <-- TAMBAHKAN BARIS INI

class Kelas extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'kelas';
    protected $fillable = ['nama_kelas'];

    /**
     * Relasi ke Siswa: Satu Kelas memiliki banyak Siswa
     */
    public function siswa()
    {
        return $this->hasMany(Siswa::class, 'id_kelas');
    }

    /**
     * Scope untuk mengambil peringkat kelas teraktif.
     */
    public function scopePeringkatTeraktif($query)
    {
        return $query->select('nama_kelas', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
            ->join('siswa', 'kelas.id', '=', 'siswa.id_kelas')
            ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
            ->groupBy('nama_kelas')
            ->orderByDesc('total_jumlah')
            ->limit(5);
    }
}