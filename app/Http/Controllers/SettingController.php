<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use ZipArchive;

class SettingController extends Controller
{
    /**
     * Menampilkan halaman pengaturan.
     */
    public function index()
    {
        $settings = Setting::pluck('value', 'key');
        return view('pages.settings.index', compact('settings'));
    }

    /**
     * Memperbarui pengaturan website dan honor.
     */
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

    /**
     * Menangani proses backup database (Versi Perbaikan).
     */
    public function backup()
    {
        try {
            // Bersihkan cache config untuk memastikan pengaturan backup terbaru yang dibaca
            Artisan::call('config:clear');

            // Jalankan perintah backup hanya untuk database
            Artisan::call('backup:run', ['--only-db' => true]);

            // Dapatkan nama disk dari file konfigurasi backup
            $diskName = config('backup.backup.destination.disks')[0];
            $disk = Storage::disk($diskName);

            // Dapatkan semua file dari direktori backup
            $files = $disk->allFiles(config('backup.backup.name'));

            if (empty($files)) {
                return back()->with('toastr-error', 'Backup berhasil diproses, tetapi tidak ada file yang ditemukan di direktori penyimpanan. Periksa konfigurasi disk Anda.');
            }

            // Urutkan file berdasarkan waktu modifikasi untuk menemukan yang paling baru
            usort($files, function ($a, $b) use ($disk) {
                return $disk->lastModified($b) <=> $disk->lastModified($a);
            });

            // Ambil file yang paling baru (elemen pertama setelah diurutkan)
            $latestFile = $files[0];

            // Unduh file backup terbaru
            return $disk->download($latestFile);

        } catch (\Exception $e) {
            return back()->with('toastr-error', 'Gagal membuat backup: ' . $e->getMessage());
        }
    }


    /**
     * Menangani proses restore database.
     */
    public function restore(Request $request)
    {
        $request->validate([
            'backup_file' => 'required|file|mimes:zip',
        ]);

        $file = $request->file('backup_file');
        $path = $file->storeAs('temp', $file->getClientOriginalName());
        $storagePath = storage_path('app/' . $path);

        $zip = new ZipArchive;
        if ($zip->open($storagePath) === TRUE) {
            $zip->extractTo(storage_path('app/temp/unzipped'));
            $zip->close();

            $sqlFiles = glob(storage_path('app/temp/unzipped/db-dumps/*.sql'));
            if (!empty($sqlFiles)) {
                $sqlFile = $sqlFiles[0];

                try {
                    DB::statement('SET FOREIGN_KEY_CHECKS=0;');
                    $tables = DB::select('SHOW TABLES');
                    $dbName = DB::getDatabaseName();
                    $tablesInDbKey = "Tables_in_{$dbName}";
                    foreach($tables as $table){
                        DB::statement('DROP TABLE IF EXISTS '. $table->$tablesInDbKey);
                    }
                    DB::unprepared(file_get_contents($sqlFile));
                    DB::statement('SET FOREIGN_KEY_CHECKS=1;');
                    Storage::deleteDirectory('temp');
                    return back()->with('toastr-success', 'Database berhasil dipulihkan!');
                } catch (\Exception $e) {
                    Storage::deleteDirectory('temp');
                    return back()->with('toastr-error', 'Terjadi kesalahan saat restore: ' . $e->getMessage());
                }
            }
        }

        Storage::deleteDirectory('temp');
        return back()->with('toastr-error', 'Gagal memulihkan database. Pastikan file backup valid.');
    }
}