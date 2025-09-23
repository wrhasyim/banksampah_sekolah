<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class BukuKas extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'buku_kas';

    /**
     * The attributes that are mass assignable.
     * Sesuai dengan skema tabel Anda.
     */
    protected $fillable = [
        'tanggal',
        'deskripsi',
        'tipe',
        'jumlah',
        'id_admin',
        'id_kategori',
    ];

    /**
     * Relasi ke KategoriTransaksi dengan nama 'kategori'.
     */
    public function kategori()
    {
        return $this->belongsTo(KategoriTransaksi::class, 'id_kategori');
    }

    /**
     * Relasi ke Admin/Pengguna.
     */
    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'id_admin');
    }
}