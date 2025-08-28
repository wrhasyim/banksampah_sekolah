<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\BukuKasController;
use App\Http\Controllers\KategoriTransaksiController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\LeaderboardController;
use App\Http\Controllers\BukuTabunganController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', [DashboardController::class, 'index'])->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {
    Route::resource('jenis-sampah', JenisSampahController::class);

    // Siswa Routes
    Route::get('siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::post('siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('siswa/sample-export', [SiswaController::class, 'sampleExport'])->name('siswa.sample.export');
    Route::get('siswa/export', [SiswaController::class, 'export'])->name('siswa.export');
    Route::resource('siswa', SiswaController::class);

    // Setoran Routes (FIX: Specific routes moved before resource route)
    Route::get('setoran/massal', [SetoranController::class, 'createMassal'])->name('setoran.create.massal');
    Route::post('setoran/massal', [SetoranController::class, 'storeMassal'])->name('setoran.store.massal');
    Route::get('setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::post('setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
    Route::get('setoran/sample-export', [SetoranController::class, 'sampleExport'])->name('setoran.sample.export');
    Route::get('/setoran/get-siswa', [SetoranController::class, 'getSiswa'])->name('setoran.getSiswa');
    Route::resource('setoran', SetoranController::class)->except(['show', 'edit', 'update', 'destroy']); // Optional: Menghapus route yang tidak dipakai
// Route baru yang disarankan
Route::get('setoran', [App\Http\Controllers\SetoranController::class, 'index'])->name('setoran.index');
Route::get('setoran/massal', [App\Http\Controllers\SetoranController::class, 'createMassal'])->name('setoran.create.massal');
Route::post('setoran/massal', [App\Http\Controllers\SetoranController::class, 'storeMassal'])->name('setoran.store.massal');
Route::get('get-siswa-by-kelas', [App\Http\Controllers\SetoranController::class, 'getSiswaByKelas'])->name('get-siswa-by-kelas');
    // Penarikan Routes
    Route::get('penarikan/kelas', [PenarikanController::class, 'createKelas'])->name('penarikan.create.kelas');
    Route::post('penarikan/kelas', [PenarikanController::class, 'storeKelas'])->name('penarikan.store.kelas');
    Route::resource('penarikan', PenarikanController::class);
    
    // Other Admin Routes
    Route::resource('kelas', KelasController::class);
    Route::resource('penjualan', PenjualanController::class);
    Route::get('settings', [SettingController::class, 'index'])->name('settings.index');
    Route::post('settings', [SettingController::class, 'update'])->name('settings.update');
    Route::resource('buku-kas', BukuKasController::class);
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);
    Route::get('laporan', [ReportController::class, 'index'])->name('laporan.index');
    Route::get('laporan/export/transaksi', [ReportController::class, 'exportTransaksi'])->name('laporan.export.transaksi');
    Route::get('laporan/export/penjualan', [ReportController::class, 'exportPenjualan'])->name('laporan.export.penjualan');
    Route::get('laporan/export/buku-kas', [ReportController::class, 'exportBukuKas'])->name('laporan.export.buku-kas');
    Route::get('laporan/export-pdf/transaksi', [ReportController::class, 'exportTransaksiPdf'])->name('laporan.export-pdf.transaksi');
    Route::get('laporan/export-pdf/penjualan', [ReportController::class, 'exportPenjualanPdf'])->name('laporan.export-pdf.penjualan');
    Route::get('laporan/export-pdf/laba-rugi', [ReportController::class, 'exportLabaRugiPdf'])->name('laporan.export-pdf.laba-rugi');
    Route::get('laporan/export-pdf/buku-kas', [ReportController::class, 'exportBukuKasPdf'])->name('laporan.export-pdf.buku-kas');
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
});

// AJAX route for getting students by class
Route::get('/kelas/{kelas}/siswa', [KelasController::class, 'getSiswaByKelas'])->middleware(['auth', 'role:admin'])->name('kelas.getSiswa');

Route::middleware(['auth', 'verified', 'role:siswa'])->group(function () {
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
});

require __DIR__.'/auth.php';