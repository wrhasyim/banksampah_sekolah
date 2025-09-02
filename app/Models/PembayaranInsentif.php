<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PembayaranInsentif extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'pembayaran_insentifs';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
     protected $fillable = [
        'id_admin',
        'id_wali_kelas',
        'tanggal_pembayaran',
        'total_dibayar', // <-- PASTIKAN NAMA KOLOM DI SINI BENAR
        'bukti_pembayaran',
    ];

    /**
     * Get the wali kelas that owns the pembayaran insentif.
     */
    public function waliKelas()
    {
        // Asumsi relasi ke model Pengguna dimana role='wali_kelas'
        return $this->belongsTo(Pengguna::class, 'id_wali_kelas');
    }
}