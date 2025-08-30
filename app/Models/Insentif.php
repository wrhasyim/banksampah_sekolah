<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Insentif extends Model
{
    use HasFactory;

    protected $fillable = [
        'penjualan_id',
        'kelas_id',
        'jumlah_insentif',
    ];

    public function penjualan()
    {
        return $this->belongsTo(Penjualan::class);
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class);
    }
}