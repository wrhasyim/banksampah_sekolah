<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\BukuTabunganController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\KelasController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/buku-tabungan', [BukuTabunganController::class, 'index'])
    ->middleware(['auth', 'verified'])->name('buku-tabungan.index');

require __DIR__.'/auth.php';

Route::middleware(['auth', 'role:admin'])->group(function () {
    
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Menggunakan Route::resource dengan pengecualian
    Route::resource('jenis-sampah', JenisSampahController::class);
    Route::resource('kelas', KelasController::class);
    // Kita kecualikan 'show' karena kita tidak memilikinya
    Route::resource('siswa', SiswaController::class)->except(['show']);
    Route::resource('setoran', SetoranController::class)->except(['show']);
    Route::resource('penarikan', PenarikanController::class)->only(['index', 'create', 'store']);

    // Rute kustom untuk impor Siswa
    Route::get('/siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::post('/siswa/import', [SiswaController::class, 'import'])->name('siswa.import');

    // Rute kustom untuk impor Setoran
    Route::get('/setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::post('/setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
});

require __DIR__.'/auth.php';