<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use App\Models\Setoran;

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'siswa';

    protected $fillable = [
        'id_pengguna',
        'id_kelas',
        'nis',
        'saldo',
        'points',
    ];

    /**
     * Get the user that owns the Siswa.
     */
    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_pengguna');
    }

    /**
     * Get the kelas for the siswa.
     */
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas');
    }

    /**
     * Get the setoran for the siswa.
     */
    public function setoran()
    {
        return $this->hasMany(Setoran::class, 'siswa_id');
    }

    /**
     * ========================================================================
     * FUNGSI RELASI BARU DITAMBAHKAN DI SINI
     * ========================================================================
     */

    /**
     * Mendapatkan SATU setoran terakhir untuk siswa ini.
     * Penting untuk fitur "Laporan Siswa Tidak Aktif".
     */
    public function setoranTerakhir()
    {
        // Relasi ini mengambil SATU record setoran terbaru.
        // Kita gunakan 'siswa_id' agar konsisten dengan relasi 'setoran' di atas.
        return $this->hasOne(Setoran::class, 'siswa_id')->latestOfMany('created_at');
    }
    
    /**
     * ========================================================================
     * AKHIR FUNGSI BARU
     * ========================================================================
     */


    /**
     * Get the penarikan for the siswa.
     */
    public function penarikan()
    {
        return $this->hasMany(Penarikan::class, 'siswa_id');
    }

    /**
     * The badges that belong to the Siswa.
     */
    public function badges()
    {
        return $this->belongsToMany(Badge::class, 'badge_siswa');
    }

    /**
     * Relasi untuk mengambil rincian total sampah per jenis (untuk leaderboard efisien).
     */
    public function sampahDetails()
    {
        return $this->hasMany(Setoran::class)
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
            ->where('setoran.status', '!=', 'terlambat')
            ->select(
                'setoran.siswa_id',
                'jenis_sampah.nama_sampah as nama_jenis',
                'jenis_sampah.satuan',
                DB::raw('SUM(setoran.jumlah) as total_jumlah')
            )
            ->groupBy('setoran.siswa_id', 'jenis_sampah.nama_sampah', 'jenis_sampah.satuan')
            ->orderBy('jenis_sampah.nama_sampah');
    }
}