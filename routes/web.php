<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

use App\Http\Controllers\DashboardController;
// ...
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])->name('dashboard');

// ... baris lain

require __DIR__.'/auth.php';

// -- TAMBAHKAN KODE DI BAWAH INI --
Route::middleware(['auth', 'role:admin'])->group(function () {
   
    Route::get('/profile', [\App\Http\Controllers\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [\App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [\App\Http\Controllers\ProfileController::class, 'destroy'])->name('profile.destroy');

    // --- GRUP RUTE UNTUK JENIS SAMPAH ---
    Route::get('/jenis-sampah', [\App\Http\Controllers\JenisSampahController::class, 'index'])->name('jenis-sampah.index');
    Route::get('/jenis-sampah/create', [\App\Http\Controllers\JenisSampahController::class, 'create'])->name('jenis-sampah.create');
    Route::post('/jenis-sampah', [\App\Http\Controllers\JenisSampahController::class, 'store'])->name('jenis-sampah.store');
    Route::get('/jenis-sampah/{jenisSampah}/edit', [\App\Http\Controllers\JenisSampahController::class, 'edit'])->name('jenis-sampah.edit');
    Route::put('/jenis-sampah/{jenisSampah}', [\App\Http\Controllers\JenisSampahController::class, 'update'])->name('jenis-sampah.update');
    Route::delete('/jenis-sampah/{jenisSampah}', [\App\Http\Controllers\JenisSampahController::class, 'destroy'])->name('jenis-sampah.destroy'); // <-- RUTE BARU

// Menggunakan Route::resource untuk cara yang lebih efisien
    Route::resource('jenis-sampah', \App\Http\Controllers\JenisSampahController::class);
    Route::resource('kelas', \App\Http\Controllers\KelasController::class); // <-- TAMBAHKAN INI
    Route::resource('siswa', \App\Http\Controllers\SiswaController::class); // <-- TAMBAHKAN INI
    Route::resource('setoran', \App\Http\Controllers\SetoranController::class); // <-- TAMBAHKAN INI
    Route::resource('penarikan', \App\Http\Controllers\PenarikanController::class)->only(['index', 'create', 'store']); // <-- TAMBAHKAN INI

});

require __DIR__.'/auth.php';
