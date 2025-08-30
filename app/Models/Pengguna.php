<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Pengguna extends Authenticatable
{
    use HasFactory, Notifiable;

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
}