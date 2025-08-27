<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kelas extends Model
{
    use HasFactory;

    protected $table = 'kelas';
    protected $fillable = ['nama'];

    /**
     * Mendapatkan semua siswa di dalam kelas ini.
     */
    public function siswa()
    {
        return $this->hasMany(Siswa::class, 'id_kelas');
    }

    /**
     * PERBAIKAN: Mendapatkan semua setoran dari semua siswa di kelas ini.
     * Ini adalah relasi "Has Many Through".
     */
    public function setoran()
    {
        return $this->hasManyThrough(Setoran::class, Siswa::class, 'id_kelas', 'siswa_id');
    }
}