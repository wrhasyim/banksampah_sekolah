<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Insentif extends Model
{
    use HasFactory;

    protected $fillable = [
        'setoran_id',
        'kelas_id',
        'jumlah_insentif',
        'status_pembayaran', // Tambahkan ini
        'pembayaran_insentif_id', // Tambahkan ini
    ];

    // ... (sisa relasi tidak berubah) ...

    public function setoran()
    {
        return $this->belongsTo(Setoran::class);
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class);
    }
}