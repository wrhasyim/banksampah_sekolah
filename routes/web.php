<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\KelasController;
use App\Http\Controllers\SetoranController;
use App\Http\Controllers\PenarikanController;
use App\Http\Controllers\BukuTabunganController;
use App\Http\Controllers\JenisSampahController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\BukuKasController;
use App\Http\Controllers\KategoriTransaksiController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\LeaderboardController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\PembayaranInsentifController;
use App\Http\Controllers\InsentifController;
use App\Http\Controllers\ChartController;
use App\Http\Controllers\NotaController;
use App\Http\Controllers\PenggunaController;
use App\Http\Controllers\RekapanController;

// Halaman utama, arahkan ke login atau dashboard
Route::get('/', function () {
    return auth()->check() ? redirect('/dashboard') : app(AuthenticatedSessionController::class)->create();
})->name('home');

// Dashboard utama
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

// Grup rute yang hanya bisa diakses oleh admin
Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {
    
    // Master Data
    Route::resource('kelas', KelasController::class);
    Route::resource('jenis-sampah', JenisSampahController::class);
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);
    Route::resource('pengguna', PenggunaController::class)->except(['show']);

    // Manajemen Siswa (termasuk import/export)
    Route::prefix('siswa')->name('siswa.')->group(function () {
        Route::get('/export', [SiswaController::class, 'export'])->name('export');
        Route::get('/sample-export', [SiswaController::class, 'sampleExport'])->name('sample.export');
        Route::get('/import', [SiswaController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SiswaController::class, 'import'])->name('import');
    });
    Route::resource('siswa', SiswaController::class);

    // Transaksi Setoran (termasuk import/export & massal)
    Route::prefix('setoran')->name('setoran.')->group(function () {
        Route::get('/export', [SetoranController::class, 'export'])->name('export');
        Route::get('/sample-export', [SetoranController::class, 'sampleExport'])->name('sample.export');
        Route::get('/import', [SetoranController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SetoranController::class, 'import'])->name('import');
        Route::get('/create-massal', [SetoranController::class, 'createMassal'])->name('create.massal');
        // ===== BARIS INI TELAH DIPERBAIKI =====
        Route::post('/store-massal', [SetoranController::class, 'storeMassal'])->name('store.massal');
    });
    Route::resource('setoran', SetoranController::class);

    // Transaksi Penarikan (termasuk penarikan per kelas)
    Route::prefix('penarikan')->name('penarikan.')->group(function () {
        Route::get('/create/kelas', [PenarikanController::class, 'createKelas'])->name('create.kelas');
        Route::post('/store/kelas', [PenarikanController::class, 'storeKelas'])->name('store.kelas');
    });
    Route::resource('penarikan', PenarikanController::class);

    // Transaksi Penjualan
    Route::resource('penjualan', PenjualanController::class);
    
    // Keuangan & Laporan
    Route::resource('buku-kas', BukuKasController::class)->except(['create', 'show']);
    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
    
    // Laporan
    Route::prefix('laporan')->name('laporan.')->group(function () {
        Route::get('/', [ReportController::class, 'index'])->name('index');
        Route::get('/penjualan/export/excel', [ReportController::class, 'exportPenjualanExcel'])->name('penjualan.export.excel');
        Route::get('/penjualan/export/pdf', [ReportController::class, 'exportPenjualanPdf'])->name('penjualan.export.pdf');
        Route::get('/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('transaksi.export.excel');
        Route::get('/transaksi/export/pdf', [ReportController::class, 'exportTransaksiPdf'])->name('transaksi.export.pdf');
        Route::get('/laba-rugi/export/pdf', [ReportController::class, 'exportLabaRugiPdf'])->name('laba-rugi.export.pdf');
    });

    // Rekapan Khusus
    Route::get('/rekapan-siswa', [RekapanController::class, 'index'])->name('rekapan.index');
    Route::get('/rekapan-siswa/export-pdf', [RekapanController::class, 'exportSiswaPdf'])->name('rekapan.exportSiswaPdf');
    Route::get('/rekapan-guru', [RekapanController::class, 'indexGuru'])->name('rekapan.indexGuru');
    Route::get('/rekapan-guru/export-pdf', [RekapanController::class, 'exportGuruPdf'])->name('rekapan.exportGuruPdf');

    // Insentif
    Route::get('/insentif', [InsentifController::class, 'index'])->name('insentif.index');
    Route::get('/insentif/rekap', [InsentifController::class, 'rekap'])->name('insentif.rekap');
    Route::get('/insentif/pembayaran', [PembayaranInsentifController::class, 'index'])->name('insentif.pembayaran');
    Route::post('/insentif/bayar', [PembayaranInsentifController::class, 'store'])->name('insentif.bayar');
    
    // Fitur Lainnya
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
    Route::get('/nota', [NotaController::class, 'index'])->name('nota.index');
    Route::post('/nota/cetak', [NotaController::class, 'cetak'])->name('nota.cetak');
    Route::get('settings', [SettingController::class, 'index'])->name('settings.index');
    Route::post('settings', [SettingController::class, 'update'])->name('settings.update');

    // Data untuk Chart (API-like)
    Route::get('/dashboard/chart-data', [DashboardController::class, 'getChartData'])->name('dashboard.chart.data');
    Route::get('/dashboard/chart/transaksi', [ChartController::class, 'getTransaksiChartData'])->name('dashboard.chart.transaksi');
    Route::get('/dashboard/chart/sampah', [ChartController::class, 'getSampahChartData'])->name('dashboard.chart.sampah');
});

// API untuk frontend (misal: Ambil siswa berdasarkan kelas)
Route::get('/api/siswa-by-kelas/{kelasId}', [SiswaController::class, 'getSiswaByKelas'])
    ->middleware('auth')
    ->name('api.siswa.by.kelas');

// Rute untuk otentikasi (login, register, dll.)
require __DIR__.'/auth.php';