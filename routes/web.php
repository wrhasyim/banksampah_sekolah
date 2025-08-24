<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\BukuTabunganController;
use App\Http\Controllers\ReportController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/buku-tabungan', [BukuTabunganController::class, 'index'])
    ->middleware(['auth', 'verified'])->name('buku-tabungan.index');

Route::middleware(['auth', 'role:admin'])->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Resource Routes
    Route::resource('jenis-sampah', JenisSampahController::class);
    Route::resource('kelas', KelasController::class);
    Route::resource('siswa', \App\Http\Controllers\SiswaController::class)->except(['show']);
    Route::resource('setoran', SetoranController::class)->only(['index', 'create', 'store']);
    Route::resource('penarikan', PenarikanController::class)->only(['index', 'create', 'store']);

    // Laporan Routes
    Route::get('/laporan/setoran', [ReportController::class, 'index'])->name('laporan.setoran.index');
    Route::post('/laporan/setoran', [ReportController::class, 'index'])->name('laporan.setoran.filter');
    Route::post('/laporan/setoran/export', [ReportController::class, 'exportSetoran'])->name('laporan.setoran.export');

    // Impor Siswa Routes
    Route::get('/siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::post('/siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('/siswa/export-sample', [SiswaController::class, 'exportSample'])->name('siswa.export.sample'); // <-- TAMBAHKAN INI

    // Impor Setoran Routes
    Route::get('/setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::post('/setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
    Route::get('/setoran/export-sample', [SetoranController::class, 'exportSample'])->name('setoran.export.sample'); // <-- TAMBAHKAN INI
    
    // Rute untuk mengambil siswa berdasarkan kelas (AJAX)
    Route::get('/get-siswa-by-kelas/{id_kelas}', [SiswaController::class, 'getByKelas'])->name('siswa.getByKelas');

});

require __DIR__.'/auth.php';