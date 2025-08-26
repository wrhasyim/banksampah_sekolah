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
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\BukuKasController; 
use App\Http\Controllers\KategoriTransaksiController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Rute Publik
Route::get('/', function () {
    return view('welcome');
});

// Rute yang Membutuhkan Login (untuk Siswa & Admin)
Route::middleware(['auth', 'verified'])->group(function() {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
    Route::get('/buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');

    // --- RUTE PROFIL DIPINDAHKAN KE SINI ---
    // Semua pengguna yang login bisa mengakses profil mereka.
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});


// Rute Khusus Admin
Route::middleware(['auth', 'role:admin'])->group(function () {
    // CRUD Routes
    Route::resource('jenis-sampah', JenisSampahController::class);
    Route::resource('kelas', KelasController::class);
    Route::resource('siswa', SiswaController::class)->except(['show']);
    Route::resource('setoran', SetoranController::class)->only(['index', 'create', 'store']);
    Route::resource('penarikan', PenarikanController::class)->only(['index', 'create', 'store']);
    Route::resource('penjualan', PenjualanController::class)->only(['index', 'create', 'store', 'show']);

    // Rute Tambahan Penarikan
    Route::get('/penarikan/kelas', [PenarikanController::class, 'createKelas'])->name('penarikan.createKelas');
    Route::post('/penarikan/kelas', [PenarikanController::class, 'storeKelas'])->name('penarikan.storeKelas');

    // Laporan Routes
    Route::prefix('laporan')->name('laporan.')->group(function () {
        Route::get('/', [ReportController::class, 'index'])->name('index');
        Route::post('/', [ReportController::class, 'index'])->name('filter');
        Route::post('/export', [ReportController::class, 'export'])->name('export');
    });

    // Rute Tambahan Siswa (Impor, Ekspor, AJAX)
    Route::get('/siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::post('/siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('/siswa/export-sample', [SiswaController::class, 'exportSample'])->name('siswa.export.sample');
     Route::post('/siswa/export', [SiswaController::class, 'export'])->name('siswa.export'); // <-- TAMBAHKAN INI
    Route::get('/get-siswa-by-kelas/{id_kelas}', [SiswaController::class, 'getByKelas'])->name('siswa.getByKelas');
    
    // Rute Tambahan Setoran (Impor)
    Route::get('/setoran/import', [SetoranController::class, 'showImportForm'])->name('setoran.import.form');
    Route::post('/setoran/import', [SetoranController::class, 'import'])->name('setoran.import');
    Route::get('/setoran/export-sample', [SetoranController::class, 'exportSample'])->name('setoran.export.sample');

// Rute untuk Buku Kas (menggantikan Kas Kecil)
    Route::get('/buku-kas', [BukuKasController::class, 'index'])->name('buku-kas.index');
    Route::post('/buku-kas', [BukuKasController::class, 'store'])->name('buku-kas.store');
    Route::delete('/buku-kas/{bukuKa}', [BukuKasController::class, 'destroy'])->name('buku-kas.destroy');
    Route::resource('kategori-transaksi', KategoriTransaksiController::class)->except(['show']); // Route untuk Kategori
// Route untuk menampilkan form edit
Route::get('/buku-kas/{bukuKa}/edit', [BukuKasController::class, 'edit'])->name('buku-kas.edit');
// Route untuk memproses update
Route::put('/buku-kas/{bukuKa}', [BukuKasController::class, 'update'])->name('buku-kas.update');
    // Rute Pengaturan
    Route::get('/settings', [SettingController::class, 'index'])->name('settings.index');
Route::post('/settings', [SettingController::class, 'update'])->name('settings.update');

Route::get('buku-kas-export-excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas-export-pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');
});


require __DIR__.'/auth.php';