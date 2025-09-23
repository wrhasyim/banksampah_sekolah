<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SaldoBulanan extends Model
{
    use HasFactory;

    protected $table = 'saldo_bulanan';

    protected $fillable = [
        'periode',
        'saldo_awal',
        'total_pemasukan',
        'total_pengeluaran',
        'saldo_akhir',
        'ditutup_pada',
        'ditutup_oleh',
    ];

    protected $casts = [
        'periode' => 'date',
        'ditutup_pada' => 'datetime',
    ];

    public function admin()
    {
        return $this->belongsTo(Pengguna::class, 'ditutup_oleh');
    }
}