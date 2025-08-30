<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\BukuTabunganController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\BukuKasController;
use App\Http\Controllers\KategoriTransaksiController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\LeaderboardController;
use App\Http\Controllers\DashboardController;

// Rute untuk halaman utama
Route::get('/', function () {
    if (auth()->check()) {
        return redirect('/dashboard');
    }
    return app(AuthenticatedSessionController::class)->create();
})->name('home');

// Rute untuk dashboard
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

// Grup rute yang memerlukan role admin
Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {
    // CRUD Kelas
    Route::resource('kelas', KelasController::class);

    // CRUD Siswa
    Route::get('siswa/export', [SiswaController::class, 'export'])->name('siswa.export');
    Route::get('siswa/sample-export', [SiswaController::class, 'sampleExport'])->name('siswa.sample.export');
    Route::post('siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    // PERBAIKAN: Menambahkan route untuk mengambil siswa berdasarkan kelas
    Route::get('/get-siswa-by-kelas/{id_kelas}', [SiswaController::class, 'getSiswaByKelas'])->name('siswa.get-by-kelas');
    Route::resource('siswa', SiswaController::class);

    // CRUD Jenis Sampah
    Route::resource('jenis-sampah', JenisSampahController::class);

    // Transaksi Setoran
    Route::get('setoran/export', [SetoranController::class, 'export'])->name('setoran.export');
    Route::get('setoran/sample-export', [SetoranController::class, 'sampleExport'])->name('setoran.sample.export');
    Route::post('setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
    Route::get('setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::get('setoran/create-massal', [SetoranController::class, 'createMassal'])->name('setoran.create.massal');
    Route::post('setoran/store-massal', [SetoranController::class, 'storeMassal'])->name('setoran.store.massal');
    Route::resource('setoran', SetoranController::class);

    // Transaksi Penarikan
    Route::get('penarikan/create/kelas', [PenarikanController::class, 'createKelas'])->name('penarikan.create.kelas');
    Route::post('penarikan/store/kelas', [PenarikanController::class, 'storeKelas'])->name('penarikan.store.kelas');
    Route::resource('penarikan', PenarikanController::class);

    // Laporan Buku Tabungan
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
Route::get('/insentif', [App\Http\Controllers\InsentifController::class, 'index'])->name('insentif.index');
    // Penjualan
    Route::resource('penjualan', PenjualanController::class);
// Tambahkan baris ini di dalam grup middleware 'auth' atau di tempat yang sesuai
Route::get('/dashboard/chart-data', [App\Http\Controllers\DashboardController::class, 'getChartData'])->name('dashboard.chart');
    // Buku Kas
    Route::resource('buku-kas', BukuKasController::class)->except(['create', 'show']);
    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');

    // Kategori Transaksi
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);

    // Pengaturan
    Route::get('settings', [SettingController::class, 'index'])->name('settings.index');
    Route::post('settings', [SettingController::class, 'store'])->name('settings.store');
// Perbaikan: Tambahkan rute untuk pembaruan pengaturan
     Route::post('settings', [SettingController::class, 'update'])->name('settings.update');
    
    // Laporan
    Route::get('/laporan', [ReportController::class, 'index'])->name('laporan.index');
    Route::get('/laporan/penjualan/export/excel', [ReportController::class, 'exportPenjualanExcel'])->name('laporan.penjualan.export.excel');
    Route::get('/laporan/penjualan/export/pdf', [ReportController::class, 'exportPenjualanPdf'])->name('laporan.penjualan.export.pdf');
    Route::get('/laporan/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('laporan.transaksi.export.excel');
    Route::get('/laporan/transaksi/export/pdf', [ReportController::class, 'exportTransaksiPdf'])->name('laporan.transaksi.export.pdf');
    Route::get('/laporan/laba-rugi/export/pdf', [ReportController::class, 'exportLabaRugiPdf'])->name('laporan.laba-rugi.export.pdf');

    // Leaderboard
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');

      Route::prefix('setoran')->name('setoran.')->group(function () {
        // ... route setoran lainnya
        Route::get('/create-massal', [SetoranController::class, 'createMassal'])->name('create.massal');
        // TAMBAHKAN BARIS DI BAWAH INI
        Route::post('/store-massal', [SetoranController::class, 'storeMassal'])->name('storeMassal');
    });
});
Route::get('/get-siswa-by-kelas/{id_kelas}', [App\Http\Controllers\SiswaController::class, 'getSiswaByKelas'])->middleware('auth');
// Rute untuk profil pengguna
require __DIR__.'/auth.php';