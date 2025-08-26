<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Badge extends Model
{
public function siswa()
{
    return $this->belongsToMany(Siswa::class, 'badge_siswa');
}
}
