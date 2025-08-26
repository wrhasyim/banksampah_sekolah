<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB; // <-- TAMBAHKAN BARIS INI

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'siswa';
    protected $fillable = ['id_pengguna', 'id_kelas', 'nis', 'saldo'];

    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_pengguna');
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    public function setoran()
    {
        return $this->hasMany(Setoran::class, 'id_siswa');
    }

    public function penarikan()
    {
        return $this->hasMany(Penarikan::class, 'id_siswa');
    }

    /**
     * Scope untuk mengambil peringkat siswa teraktif.
     */
    public function scopePeringkatTeraktif($query)
    {
        return $query->select('id_pengguna', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
            ->join('setoran', 'siswa.id', '=', 'setoran.id_siswa')
            ->with('pengguna')
            ->groupBy('id_pengguna')
            ->orderByDesc('total_jumlah')
            ->limit(5);
    }
}