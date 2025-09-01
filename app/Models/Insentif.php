<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Insentif extends Model
{
    use HasFactory;

    protected $fillable = [
        'setoran_id', // <-- Perubahan di sini
        'kelas_id',
        'jumlah_insentif',
    ];

    // Relasi ke Setoran
    public function setoran()
    {
        return $this->belongsTo(Setoran::class);
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class);
    }
}