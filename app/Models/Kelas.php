<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough; // Pastikan baris ini ada

class Kelas extends Model
{
    use HasFactory;
    protected $table = 'kelas';
    protected $guarded = ['id'];


    public function siswa(): HasMany
    {
        return $this->hasMany(Siswa::class, 'id_kelas');
    }

    /**
     * Define a has-many-through relationship.
     * Mendapatkan semua setoran untuk kelas ini melalui siswa.
     */
    public function setoran(): HasManyThrough
    {
        return $this->hasManyThrough(Setoran::class, Siswa::class, 'id_kelas', 'siswa_id');
    }
}