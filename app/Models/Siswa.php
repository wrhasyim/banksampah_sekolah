<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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
        // PERBAIKAN: Menggunakan 'siswa_id' sesuai dengan file migrasi
        return $this->hasMany(Setoran::class, 'siswa_id');
    }

    public function penarikan()
    {
        // PERBAIKAN: Menggunakan 'siswa_id' sesuai dengan file migrasi
        return $this->hasMany(Penarikan::class, 'siswa_id');
    }
    
    public function badges()
    {
        return $this->belongsToMany(Badge::class, 'badge_siswa');
    }
    
    public function scopePeringkatTeraktif($query)
    {
        return $query->select('id_pengguna', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
            // PERBAIKAN: Menggunakan 'siswa_id' untuk join
            ->join('setoran', 'siswa.id', '=', 'setoran.siswa_id')
            ->with('pengguna')
            ->groupBy('id_pengguna')
            ->orderByDesc('total_jumlah')
            ->limit(5);
    }
}