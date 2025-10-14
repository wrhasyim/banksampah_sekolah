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
use App\Http\Controllers\TutupBukuController;
use App\Http\Controllers\StokMasukController;
use App\Http\Controllers\RewardController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Halaman utama, arahkan ke login atau dashboard
Route::get('/', function () {
    return auth()->check() ? redirect()->route('dashboard') : app(AuthenticatedSessionController::class)->create();
})->name('home');

// Dashboard utama
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

// =====================================================================
// GRUP RUTE HANYA UNTUK ADMIN
// =====================================================================
Route::middleware(['auth', 'verified', 'role:admin'])->group(function () {

    // --- MASTER DATA ---
    Route::resource('kelas', KelasController::class);
    Route::resource('jenis-sampah', JenisSampahController::class);
    Route::resource('kategori-transaksi', KategoriTransaksiController::class);
    Route::resource('pengguna', PenggunaController::class)->except(['show']);
    Route::resource('rewards', RewardController::class);
    Route::resource('siswa', SiswaController::class);
    Route::prefix('siswa')->name('siswa.')->group(function () {
        Route::get('/export', [SiswaController::class, 'export'])->name('export');
        Route::get('/sample-export', [SiswaController::class, 'sampleExport'])->name('sample.export');
        Route::get('/import', [SiswaController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SiswaController::class, 'import'])->name('import');
        Route::get('/search', [SiswaController::class, 'search'])->name('search');
    });

    // --- TRANSAKSI ---
    Route::resource('setoran', SetoranController::class);
    Route::prefix('setoran')->name('setoran.')->group(function () {
        Route::get('/export', [SetoranController::class, 'export'])->name('export');
        Route::get('/import', [SetoranController::class, 'showImportForm'])->name('import.form');
        Route::post('/import', [SetoranController::class, 'import'])->name('import');
        Route::get('/create-massal', [SetoranController::class, 'createMassal'])->name('create.massal');
        Route::post('/store-massal', [SetoranController::class, 'storeMassal'])->name('store.massal');
        Route::post('/edit-massal', [SetoranController::class, 'editMassal'])->name('edit.massal');
        Route::post('/update-massal', [SetoranController::class, 'updateMassal'])->name('update.massal');
    });

    Route::resource('penarikan', PenarikanController::class);
    Route::prefix('penarikan')->name('penarikan.')->group(function () {
        Route::get('/create/kelas', [PenarikanController::class, 'createKelas'])->name('create.kelas');
        Route::post('/store/kelas', [PenarikanController::class, 'storeKelas'])->name('store.kelas');
    });
    
    Route::resource('penjualan', PenjualanController::class);
    
    Route::resource('buku-kas', BukuKasController::class)->except(['create', 'show']);
    Route::get('buku-kas/export/excel', [BukuKasController::class, 'exportExcel'])->name('buku-kas.export.excel');
    Route::get('buku-kas/export/pdf', [BukuKasController::class, 'exportPdf'])->name('buku-kas.export.pdf');

    Route::get('/stok/create', [StokMasukController::class, 'create'])->name('stok.create');
    Route::post('/stok', [StokMasukController::class, 'store'])->name('stok.store');
    
    // --- INSENTIF ---
    Route::prefix('insentif')->name('insentif.')->group(function () {
        Route::get('/', [InsentifController::class, 'index'])->name('index');
        Route::get('/rekap', [InsentifController::class, 'rekap'])->name('rekap');
        Route::get('/pembayaran', [PembayaranInsentifController::class, 'index'])->name('pembayaran');
        Route::post('/bayar', [PembayaranInsentifController::class, 'store'])->name('bayar');
        Route::get('/rekap/export-pdf', [InsentifController::class, 'exportPdf'])->name('exportPdf');
        Route::delete('/void-per-kelas', [InsentifController::class, 'voidPerKelas'])->name('voidPerKelas');
        Route::delete('/{insentif}', [InsentifController::class, 'destroy'])->name('destroy');
    });

    // --- LAPORAN & REKAPAN ---
    Route::prefix('laporan')->name('laporan.')->group(function () {
        Route::get('/', [ReportController::class, 'index'])->name('index');
        Route::get('/penjualan/export/excel', [ReportController::class, 'exportPenjualanExcel'])->name('penjualan.export.excel');
        Route::get('/penjualan/export/pdf', [ReportController::class, 'exportPenjualanPdf'])->name('penjualan.export.pdf');
        Route::get('/transaksi/export/excel', [ReportController::class, 'exportTransaksiExcel'])->name('transaksi.export.excel');
        Route::get('/transaksi/export/pdf', [ReportController::class, 'exportTransaksiPdf'])->name('transaksi.export.pdf');
        Route::get('/laba-rugi/export/pdf', [ReportController::class, 'exportLabaRugiPdf'])->name('laba-rugi.export.pdf');
    });

    Route::prefix('rekapan')->name('rekapan.')->group(function () {
        Route::get('/menyeluruh', [RekapanController::class, 'rekapMenyeluruh'])->name('menyeluruh');
        Route::get('/menyeluruh/pdf', [RekapanController::class, 'exportRekapMenyeluruhPdf'])->name('menyeluruh.pdf');
        Route::get('/siswa-terlambat', [RekapanController::class, 'indexSiswaTerlambat'])->name('siswa-terlambat');
        Route::get('/siswa-terlambat/export-pdf', [RekapanController::class, 'exportSiswaTerlambatPdf'])->name('siswa-terlambat.exportPdf');
        Route::get('/guru', [RekapanController::class, 'indexGuru'])->name('guru');
        Route::get('/guru/export-pdf', [RekapanController::class, 'exportGuruPdf'])->name('guru.exportPdf');
        Route::get('/siswa-tanpa-wali-kelas', [RekapanController::class, 'indexSiswaTanpaWaliKelas'])->name('siswa-tanpa-wali-kelas');
        Route::get('/siswa-tanpa-wali-kelas/export-pdf', [RekapanController::class, 'exportSiswaTanpaWaliKelasPdf'])->name('siswa-tanpa-wali-kelas.exportPdf');
    });

    // --- FITUR LAINNYA ---
    Route::get('/nota', [NotaController::class, 'index'])->name('nota.index');
    Route::post('/nota/cetak', [NotaController::class, 'cetak'])->name('nota.cetak');
    Route::get('/tutup-buku', [TutupBukuController::class, 'index'])->name('tutup-buku.index');
    Route::post('/tutup-buku', [TutupBukuController::class, 'store'])->name('tutup-buku.store');
    Route::prefix('settings')->name('settings.')->group(function () {
        Route::get('/', [SettingController::class, 'index'])->name('index');
        Route::post('/update', [SettingController::class, 'update'])->name('update');
        Route::post('/backup', [SettingController::class, 'backup'])->name('backup');
        Route::post('/restore', [SettingController::class, 'restore'])->name('restore');
        Route::get('/backup/download/{filename}', [SettingController::class, 'downloadBackup'])->name('backup.download');
        Route::delete('/backup/delete/{filename}', [SettingController::class, 'deleteBackup'])->name('backup.delete');
    });
});

// =====================================================================
// RUTE UNTUK SEMUA USER (TERMASUK SISWA)
// =====================================================================
Route::middleware(['auth', 'verified'])->group(function() {
    Route::get('buku-tabungan', [BukuTabunganController::class, 'index'])->name('buku-tabungan.index');
     Route::get('buku-tabungan/{siswa}', [BukuTabunganController::class, 'show'])->name('buku-tabungan.show')->middleware('role:admin');
    Route::get('/leaderboard', [LeaderboardController::class, 'index'])->name('leaderboard.index');
});

// =====================================================================
// RUTE API & AUTHENTIKASI
// =====================================================================
Route::get('/api/siswa-by-kelas/{kelasId}', [SiswaController::class, 'getSiswaByKelas'])->middleware('auth')->name('api.siswa.by.kelas');
Route::get('/select/siswa', [SiswaController::class, 'selectSiswa'])->name('select.siswa');
Route::get('/api/bukukas-chart-data', [BukuKasController::class, 'getChartData'])->name('bukukas.chart.data');
Route::get('/dashboard/chart-data', [DashboardController::class, 'getChartData'])->name('dashboard.chart.data');
Route::get('/dashboard/chart/transaksi', [ChartController::class, 'getTransaksiData'])->name('dashboard.chart.transaksi');
Route::get('/dashboard/chart/sampah', [ChartController::class, 'getSampahData'])->name('dashboard.chart.sampah');
Route::get('/dashboard/chart/bubble', [DashboardController::class, 'getBubbleChartData'])->name('dashboard.chart.bubble');

require __DIR__.'/auth.php';