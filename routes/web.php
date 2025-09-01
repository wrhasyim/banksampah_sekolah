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
use App\Http\Controllers\InsentifController;
use App\Http\Controllers\NotaController;
use App\Http\Controllers\PenggunaController;
use App\Http\Controllers\PembayaranInsentifController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Rute Halaman Utama & Dashboard
Route::get('/', function () {
    if (auth()->check()) {
        return redirect('/dashboard');
    }
    return app(AuthenticatedSessionController::class)->create();
})->name('home');

Route::get('/dashboard', [DashboardController::class, 'index'])->middleware(['auth', 'verified'])->name('dashboard');

// --- GRUP RUTE UNTUK ADMIN ---
Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {
    // Dashboard Admin
    Route::get('/dashboard/chart-data', [DashboardController::class, 'getChartData'])->name('dashboard.chart');

    // Manajemen Pengguna
    Route::resource('pengguna', PenggunaController::class)->except(['show']);

    // Manajemen Kelas
    Route::resource('kelas', KelasController::class);

    // Manajemen Siswa
    Route::get('siswa/export', [SiswaController::class, 'export'])->name('siswa.export');
    Route::get('siswa/sample-export', [SiswaController::class, 'sampleExport'])->name('siswa.sample.export');
    Route::post('siswa/import', [SiswaController::class, 'import'])->name('siswa.import');
    Route::get('siswa/import', [SiswaController::class, 'showImportForm'])->name('siswa.import.form');
    Route::get('/get-siswa-by-kelas/{id_kelas}', [SiswaController::class, 'getSiswaByKelas'])->name('siswa.get-by-kelas');
    Route::resource('siswa', SiswaController::class);

    // Manajemen Jenis Sampah
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

    // Penjualan ke Pengepul
    Route::resource('penjualan', PenjualanController::class);

    // Buku Kas & Kategori
    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');
    Route::resource('buku-kas', BukuKasController::class)->except(['create', 'show']);
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);

    // Insentif
    Route::get('/insentif', [InsentifController::class, 'index'])->name('insentif.index');
    Route::get('/insentif/rekap', [InsentifController::class, 'rekap'])->name('insentif.rekap');
    Route::get('/insentif/pembayaran', [PembayaranInsentifController::class, 'index'])->name('insentif.pembayaran');
    Route::post('/insentif/bayar', [PembayaranInsentifController::class, 'store'])->name('insentif.bayar');

    // Laporan
    Route::get('/laporan', [ReportController::class, 'index'])->name('laporan.index');
    Route::get('/laporan/penjualan/export/excel', [ReportController::class, 'exportPenjualanExcel'])->name('laporan.penjualan.export.excel');
    Route::get('/laporan/penjualan/export/pdf', [ReportController::class, 'exportPenjualanPdf'])->name('laporan.penjualan.export.pdf');
    Route::get('/laporan/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('laporan.transaksi.export.excel');
    Route::get('/laporan/transaksi/export/pdf', [ReportController::class, 'exportTransaksiPdf'])->name('laporan.transaksi.export.pdf');
    Route::get('/laporan/laba-rugi/export/pdf', [ReportController::class, 'exportLabaRugiPdf'])->name('laporan.laba-rugi.export.pdf');

    // Nota
    Route::get('/nota', [NotaController::class, 'index'])->name('nota.index');
    Route::post('/nota/cetak', [NotaController::class, 'cetak'])->name('nota.cetak');

    // Pengaturan
    Route::get('settings', [SettingController::class, 'index'])->name('settings.index');
    Route::post('settings', [SettingController::class, 'update'])->name('settings.update');

    // Leaderboard
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
});

// --- RUTE UNTUK SEMUA PENGGUNA YANG LOGIN ---
Route::middleware(['auth'])->group(function () {
    Route::get('/buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
});


require __DIR__.'/auth.php';