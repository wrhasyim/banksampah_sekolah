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

Route::get('/api/bukukas-chart-data', [\App\Http\Controllers\BukuKasController::class, 'getChartData'])->name('bukukas.chart.data');

// Rute BARU untuk Penyesuaian Stok
    Route::get('/stok/create', [\App\Http\Controllers\StokMasukController::class, 'create'])->name('stok.create');
    Route::post('/stok', [\App\Http\Controllers\StokMasukController::class, 'store'])->name('stok.store');

    // Manajemen Siswa
    Route::prefix('siswa')->name('siswa.')->group(function () {
        Route::get('/export', [SiswaController::class, 'export'])->name('export');
        Route::get('/sample-export', [SiswaController::class, 'sampleExport'])->name('sample.export');
        Route::get('/import', [SiswaController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SiswaController::class, 'import'])->name('import');
        Route::get('/search', [SiswaController::class, 'search'])->name('search'); // Tambahan untuk Select2
    });
    Route::resource('siswa', SiswaController::class);

    // Transaksi Setoran
    Route::prefix('setoran')->name('setoran.')->group(function () {
        Route::get('/export', [SetoranController::class, 'export'])->name('export');
        Route::get('/sample-export', [SetoranController::class, 'sampleExport'])->name('sample.export');
        Route::get('/import', [SetoranController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SetoranController::class, 'import'])->name('import');
        Route::get('/create-massal', [SetoranController::class, 'createMassal'])->name('create.massal');
        Route::post('/store-massal', [SetoranController::class, 'storeMassal'])->name('store.massal');
        
        // --- RUTE EDIT MASSAL DIPERBAIKI ---
        // Rute untuk menampilkan halaman edit (menggunakan POST agar bisa membawa banyak ID)
        Route::post('/edit-massal', [SetoranController::class, 'editMassal'])->name('edit.massal');
        // Rute untuk memproses update (menggunakan POST)
        Route::post('/update-massal', [SetoranController::class, 'updateMassal'])->name('update.massal');
    });
    Route::resource('setoran', SetoranController::class);

    // Transaksi Penarikan
    Route::prefix('penarikan')->name('penarikan.')->group(function () {
        Route::get('/create/kelas', [PenarikanController::class, 'createKelas'])->name('create.kelas');
        Route::post('/store/kelas', [PenarikanController::class, 'storeKelas'])->name('store.kelas');
    });
    Route::resource('penarikan', PenarikanController::class);

    // Transaksi Penjualan
    Route::resource('penjualan', PenjualanController::class);
    
    // Keuangan
    Route::resource('buku-kas', BukuKasController::class)->except(['create', 'show']);
    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');
    
    // Laporan Umum
    Route::prefix('laporan')->name('laporan.')->group(function () {
        Route::get('/', [ReportController::class, 'index'])->name('index');
        Route::get('/penjualan/export/excel', [ReportController::class, 'exportPenjualanExcel'])->name('penjualan.export.excel');
        Route::get('/penjualan/export/pdf', [ReportController::class, 'exportPenjualanPdf'])->name('penjualan.export.pdf');
        Route::get('/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('transaksi.export.excel');
        Route::get('/transaksi/export/pdf', [ReportController::class, 'exportTransaksiPdf'])->name('transaksi.export.pdf');
        Route::get('/laba-rugi/export/pdf', [ReportController::class, 'exportLabaRugiPdf'])->name('laba-rugi.export.pdf');
    });

    // --- BLOK REKAPAN KHUSUS ---
    Route::get('/rekapan-siswa/terlambat', [RekapanController::class, 'indexSiswaTerlambat'])->name('rekapan.siswa.terlambat');
    Route::get('/rekapan-siswa/terlambat/export-pdf', [RekapanController::class, 'exportSiswaTerlambatPdf'])->name('rekapan.siswa.terlambat.exportPdf');
    Route::get('/rekapan-siswa/tanpa-wali-kelas', [RekapanController::class, 'indexSiswaTanpaWaliKelas'])->name('rekapan.siswa.tanpaWaliKelas');
    Route::get('/rekapan-siswa/tanpa-wali-kelas/export-pdf', [RekapanController::class, 'exportSiswaTanpaWaliKelasPdf'])->name('rekapan.siswa.tanpaWaliKelas.exportPdf');
    Route::get('/rekapan-guru', [RekapanController::class, 'indexGuru'])->name('rekapan.indexGuru');
    Route::get('/rekapan-guru/export-pdf', [RekapanController::class, 'exportGuruPdf'])->name('rekapan.exportGuruPdf');

    // Insentif
    Route::get('/insentif', [InsentifController::class, 'index'])->name('insentif.index');
    Route::get('/insentif/rekap', [InsentifController::class, 'rekap'])->name('insentif.rekap');
    Route::get('/insentif/pembayaran', [PembayaranInsentifController::class, 'index'])->name('insentif.pembayaran');
    Route::post('/insentif/bayar', [PembayaranInsentifController::class, 'store'])->name('insentif.bayar');
    
    // Fitur Lainnya
    Route::get('/nota', [NotaController::class, 'index'])->name('nota.index');
    Route::post('/nota/cetak', [NotaController::class, 'cetak'])->name('nota.cetak');

    // Grup untuk Pengaturan, Backup, dan Restore
    Route::prefix('settings')->name('settings.')->group(function () {
        Route::get('/', [SettingController::class, 'index'])->name('index');
        Route::post('/update', [SettingController::class, 'update'])->name('update');
        Route::post('/backup', [SettingController::class, 'backup'])->name('backup');
        Route::post('/restore', [SettingController::class, 'restore'])->name('restore');
        Route::get('/backup/download/{filename}', [SettingController::class, 'downloadBackup'])->name('backup.download');
        Route::delete('/backup/delete/{filename}', [SettingController::class, 'deleteBackup'])->name('backup.delete');
    });

    // Data untuk Chart (API-like)
    Route::get('/dashboard/chart-data', [DashboardController::class, 'getChartData'])->name('dashboard.chart.data');
    Route::get('/dashboard/chart/transaksi', [ChartController::class, 'getTransaksiData'])->name('dashboard.chart.transaksi');
    Route::get('/dashboard/chart/sampah', [ChartController::class, 'getSampahData'])->name('dashboard.chart.sampah');
    Route::get('/dashboard/chart/bubble', [DashboardController::class, 'getBubbleChartData'])->name('dashboard.chart.bubble');
});

// Rute yang bisa diakses semua user yang sudah login
Route::middleware(['auth', 'verified'])->group(function() {
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
});


// API untuk frontend (misal: Ambil siswa berdasarkan kelas)
Route::get('/api/siswa-by-kelas/{kelasId}', [SiswaController::class, 'getSiswaByKelas'])
    ->middleware('auth')
    ->name('api.siswa.by.kelas');

// Rute untuk otentikasi (login, register, dll.)
require __DIR__.'/auth.php';