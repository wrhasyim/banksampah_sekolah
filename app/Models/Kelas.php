<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use App\Models\Siswa;
use App\Models\Setoran;
use App\Models\Pengguna; // <-- TAMBAHAN: Baris ini wajib ada untuk relasi 'waliKelas'

class Kelas extends Model
{
    use HasFactory;
    
    protected $table = 'kelas';
    protected $fillable = ['nama_kelas', 'id_wali_kelas'];

    public function siswa()
    {
        return $this->hasMany(Siswa::class, 'id_kelas');
    }

    public function waliKelas()
    {
        // Relasi ini sekarang akan berfungsi dengan benar
        return $this->belongsTo(Pengguna::class, 'id_wali_kelas');
    }

    public function setoran()
    {
        // Relasi ini mengambil semua 'setoran' melalui model 'siswa'
        return $this->hasManyThrough(Setoran::class, Siswa::class, 'id_kelas', 'siswa_id', 'id', 'id');
    }

    /**
     * Relasi untuk mengambil rincian total sampah per jenis (untuk leaderboard efisien).
     */
    public function sampahDetails()
    {
        return $this->hasManyThrough(
            Setoran::class,
            Siswa::class,
            'id_kelas', // Foreign key di tabel 'siswa'
            'siswa_id', // Foreign key di tabel 'setoran'
            'id',       // Local key di tabel 'kelas'
            'id'        // Local key di tabel 'siswa'
        )
        ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
        ->where('setoran.status', '!=', 'terlambat')
        ->select(
            'jenis_sampah.nama_sampah as nama_jenis',
            'jenis_sampah.satuan',
            DB::raw('SUM(setoran.jumlah) as total_jumlah')
        )
        ->groupBy('siswa.id_kelas', 'jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
        ->orderBy('jenis_sampah.nama_sampah');
    }
}