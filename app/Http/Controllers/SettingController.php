<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;

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
            // Validasi untuk persentase honor
            'persentase_pengelola' => 'required|numeric|min:0|max:100',
            'persentase_wali_kelas' => 'required|numeric|min:0|max:100',
            'persentase_sekolah' => 'required|numeric|min:0|max:100',
        ]);

        // Validasi kustom untuk memastikan total persentase tidak lebih dari 100
        $totalPersentase = $request->persentase_pengelola + $request->persentase_wali_kelas + $request->persentase_sekolah;
        if ($totalPersentase > 100) {
            return back()->withInput()->with('toastr-error', 'Total persentase honor tidak boleh lebih dari 100%.');
        }

        // Daftar semua setting yang akan di-update
        $settings = [
            'site_title' => $request->site_title,
            'persentase_pengelola' => $request->persentase_pengelola,
            'persentase_wali_kelas' => $request->persentase_wali_kelas,
            'persentase_sekolah' => $request->persentase_sekolah,
        ];

        foreach ($settings as $key => $value) {
            Setting::updateOrCreate(['key' => $key], ['value' => $value]);
        }
        
        // Handle upload favicon jika ada
        if ($request->hasFile('site_favicon')) {
            $path = $request->file('site_favicon')->store('public/logos');
            $url = \Illuminate\Support\Facades\Storage::url($path);
            Setting::updateOrCreate(['key' => 'site_favicon'], ['value' => $url]);
        }

        return redirect()->route('settings.index')->with('toastr-success', 'Pengaturan berhasil diperbarui.');
    }
}