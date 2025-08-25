<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function index()
    {
        // Ambil semua setting, ubah ke format key => value agar mudah diakses di view
        $settings = Setting::pluck('value', 'key');
        return view('pages.settings.index', compact('settings'));
    }

    public function update(Request $request)
    {
        $request->validate([
            'site_title' => 'required|string|max:255',
            'site_favicon' => 'nullable|image|mimes:ico,png,jpg|max:1024',
        ]);

        // Simpan atau update judul website
        Setting::updateOrCreate(
            ['key' => 'site_title'],
            ['value' => $request->site_title]
        );

        // Jika ada file favicon diunggah
        if ($request->hasFile('site_favicon')) {
            $path = $request->file('site_favicon')->store('public/logos');
            $url = \Illuminate\Support\Facades\Storage::url($path);

            Setting::updateOrCreate(
                ['key' => 'site_favicon'],
                ['value' => $url]
            );
        }

        return back()->with('status', 'Pengaturan berhasil disimpan!');
    }
}