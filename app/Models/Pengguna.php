<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens; // <-- DITAMBAHKAN KEMBALI (standar laravel)

// --- TAMBAHAN UNTUK RELASI ---
use App\Models\Siswa;
use App\Models\Kelas;
// --- AKHIR TAMBAHAN ---

class Pengguna extends Authenticatable
{
    // --- 'HasApiTokens' ditambahkan di sini ---
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'pengguna';

    protected $fillable = [
        'nama_lengkap',
        'username', // Mengganti email dengan username
        'password',
        'role',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    // --- DITAMBAHKAN KEMBALI (standar laravel untuk hashing) ---
    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'password' => 'hashed',
    ];
    // --- AKHIR TAMBAHAN ---


    // --- RELASI BARU UNTUK MEMPERBAIKI LOGIN SISWA ---
    /**
     * Relasi one-to-one ke Siswa.
     * Dipanggil oleh DashboardController saat siswa login.
     */
    public function siswa()
    {
        // 'id_pengguna' adalah foreign key di tabel 'siswa'
        // 'id' adalah primary key di tabel 'pengguna' (tabel ini)
        return $this->hasOne(Siswa::class, 'id_pengguna', 'id');
    }
    // --- AKHIR TAMBAHAN ---


    // --- RELASI BARU UNTUK MEMPERBAIKI DASHBOARD WALI ---
    /**
     * Relasi one-to-one ke Kelas (dimana pengguna ini adalah walinya).
     * Dipanggil oleh DashboardController saat wali login.
     */
    public function kelasYangDiampu()
    {
        // 'id_wali_kelas' adalah foreign key di tabel 'kelas'
        // 'id' adalah primary key di tabel 'pengguna' (tabel ini)
        return $this->hasOne(Kelas::class, 'id_wali_kelas', 'id');
    }
    // --- AKHIR TAMBAHAN ---
}