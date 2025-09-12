<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use ZipArchive;
use Illuminate\Support\Facades\File;

class SettingController extends Controller
{
    public function index()
    {
        $settings = Setting::pluck('value', 'key');
        return view('pages.settings.index', compact('settings'));
    }

    public function update(Request $request)
    {
        $request->validate([
            'site_title' => 'required|string|max:255',
            'site_favicon' => 'nullable|image|mimes:ico,png,jpg|max:1024',
            'persentase_pengelola' => 'required|numeric|min:0|max:100',
            'persentase_wali_kelas' => 'required|numeric|min:0|max:100',
            'persentase_sekolah' => 'required|numeric|min:0|max:100',
        ]);

        $totalPersentase = $request->persentase_pengelola + $request->persentase_wali_kelas + $request->persentase_sekolah;
        if ($totalPersentase > 100) {
            return back()->withInput()->with('toastr-error', 'Total persentase honor tidak boleh lebih dari 100%.');
        }

        $settings = [
            'site_title' => $request->site_title,
            'persentase_pengelola' => $request->persentase_pengelola,
            'persentase_wali_kelas' => $request->persentase_wali_kelas,
            'persentase_sekolah' => $request->persentase_sekolah,
        ];

        foreach ($settings as $key => $value) {
            Setting::updateOrCreate(['key' => $key], ['value' => $value]);
        }

        if ($request->hasFile('site_favicon')) {
            $path = $request->file('site_favicon')->store('public/logos');
            $url = \Illuminate\Support\Facades\Storage::url($path);
            Setting::updateOrCreate(['key' => 'site_favicon'], ['value' => $url]);
        }

        return redirect()->route('settings.index')->with('toastr-success', 'Pengaturan berhasil diperbarui.');
    }

    public function backup()
    {
        try {
            set_time_limit(300);
            Artisan::call('config:clear');
            Artisan::call('backup:run', ['--only-db' => true]);

            $diskName = config('backup.backup.destination.disks')[0];
            $disk = Storage::disk($diskName);
            $files = $disk->allFiles(config('backup.backup.name'));

            if (empty($files)) {
                return back()->with('toastr-error', 'Backup berhasil diproses, tetapi tidak ada file yang ditemukan. Pastikan XAMPP dijalankan sebagai Administrator.');
            }

            usort($files, function ($a, $b) use ($disk) {
                return $disk->lastModified($b) <=> $disk->lastModified($a);
            });

            $latestFile = $files[0];
            return $disk->download($latestFile);

        } catch (\Exception $e) {
            return back()->with('toastr-error', 'Gagal membuat backup: ' . $e->getMessage());
        }
    }

    public function restore(Request $request)
    {
        $request->validate(['backup_file' => 'required|file|mimes:zip']);

        $file = $request->file('backup_file');
        
        // --- DIAGNOSTIK DAN PERBAIKAN OTOMATIS ---
        $tempPath = storage_path('app/temp');
        $uploadError = $file->getError();

        // 1. Periksa apakah ada error saat upload dari sisi PHP
        if ($uploadError !== UPLOAD_ERR_OK) {
            return back()->with('toastr-error', 'DIAGNOSIS: Terjadi error upload PHP, kode: ' . $uploadError . '. Periksa pengaturan post_max_size dan upload_max_filesize di php.ini.');
        }

        // 2. Buat folder temp jika tidak ada
        if (!File::isDirectory($tempPath)) {
            File::makeDirectory($tempPath, 0777, true, true);
        }

        // 3. Coba simpan file
        try {
            $path = $file->storeAs('temp', 'restore.zip');
        } catch (\Exception $e) {
             return back()->with('toastr-error', 'DIAGNOSIS: Gagal menyimpan file. Pesan: ' . $e->getMessage() . '. Pastikan folder C:\xampp\tmp dan storage\app\temp memiliki izin "Full Control".');
        }

        $storagePath = storage_path('app/' . $path);

        if (!file_exists($storagePath)) {
             return back()->with('toastr-error', 'DIAGNOSIS: File gagal disimpan ke server di path: ' . $storagePath . '. Ini adalah masalah izin folder yang kritis. Jalankan XAMPP sebagai Admin dan berikan izin Full Control ke folder storage.');
        }

        // --- PROSES RESTORE NORMAL (jika semua di atas berhasil) ---
        $zip = new ZipArchive;
        if ($zip->open($storagePath) !== TRUE) {
            Storage::delete($path);
            return back()->with('toastr-error', 'Gagal membuka file backup. File mungkin rusak.');
        }

        $unzipPath = storage_path('app/temp/unzipped-restore-' . uniqid());
        $zip->extractTo($unzipPath);
        $zip->close();

        $sqlFile = null;
        $iterator = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($unzipPath));
        foreach ($iterator as $f) {
            if (strtolower($f->getExtension()) == 'sql') {
                $sqlFile = $f->getPathname();
                break;
            }
        }

        if ($sqlFile === null) {
            Storage::delete($path);
            File::deleteDirectory($unzipPath);
            return back()->with('toastr-error', 'File .sql tidak ditemukan di dalam arsip backup.');
        }

        try {
            $sqlContent = file_get_contents($sqlFile);
            if (empty(trim($sqlContent))) {
                throw new \Exception("File SQL di dalam backup kosong. Coba buat file backup baru.");
            }

            DB::statement('SET FOREIGN_KEY_CHECKS=0;');
            $tables = DB::select('SHOW TABLES');
            $dbName = DB::getDatabaseName();
            $tablesInDbKey = "Tables_in_{$dbName}";
            foreach ($tables as $table) {
                DB::statement('DROP TABLE IF EXISTS ' . $table->$tablesInDbKey);
            }
            DB::unprepared($sqlContent);
            DB::statement('SET FOREIGN_KEY_CHECKS=1;');

            Storage::delete($path);
            File::deleteDirectory($unzipPath);
            return back()->with('toastr-success', 'Database berhasil dipulihkan!');

        } catch (\Exception $e) {
            Storage::delete($path);
            File::deleteDirectory($unzipPath);
            return back()->with('toastr-error', 'Terjadi kesalahan saat restore: ' . $e->getMessage());
        }
    }
}