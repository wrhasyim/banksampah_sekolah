<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Kode penjadwalan backup harian Anda
Schedule::command('backup:run')->daily()->at('14:00');
Schedule::command('backup:clean')->daily()->at('09:00');