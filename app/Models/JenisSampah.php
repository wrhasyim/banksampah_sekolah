<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisSampah extends Model
{
    use HasFactory;
    
    protected $table = 'jenis_sampah';
     protected $fillable = ['nama_sampah', 'harga_per_satuan', 'stok'];
}