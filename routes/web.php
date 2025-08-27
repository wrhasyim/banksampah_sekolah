<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\BukuTabunganController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\BukuKasController;
use App\Http\Controllers\KategoriTransaksiController;
use App\Http\Controllers\LeaderboardController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', DashboardController::class)->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {
    
    Route::get('siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::post('siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('siswa/export/sample', [SiswaController::class, 'sampleExport'])->name('siswa.sample-export');
    Route::get('siswa/export', [SiswaController::class, 'export'])->name('siswa.export');
    Route::resource('siswa', SiswaController::class)->except(['show']);
    
    Route::resource('kelas', KelasController::class);
    Route::resource('jenis-sampah', JenisSampahController::class);
    
    Route::resource('setoran', SetoranController::class)->only([
        'index', 'create', 'store', 'destroy'
    ]);
    Route::get('setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::post('setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
    Route::get('setoran/export/sample', [SetoranController::class, 'sampleExport'])->name('setoran.sample-export');

    Route::resource('penarikan', PenarikanController::class)->except(['show', 'edit', 'update']);
    Route::get('penarikan/kelas/create', [PenarikanController::class, 'createKelas'])->name('penarikan.create.kelas');
    Route::post('penarikan/kelas', [PenarikanController::class, 'storeKelas'])->name('penarikan.storeKelas');

    Route::resource('penjualan', PenjualanController::class);

    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');
    Route::resource('buku-kas', BukuKasController::class);
    
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);
    
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
    
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
    Route::get('settings', [SettingController::class, 'index'])->name('settings.index');
    Route::post('settings', [SettingController::class, 'update'])->name('settings.update');
    
    // PERBAIKAN: Tambahkan route ini untuk mengekspor laporan transaksi
    Route::get('laporan/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('laporan.transaksi.export.excel');
    
    Route::get('laporan', [ReportController::class, 'index'])->name('laporan.index');
    Route::post('laporan/export', [ReportController::class, 'export'])->name('laporan.export');
});


require __DIR__.'/auth.php';