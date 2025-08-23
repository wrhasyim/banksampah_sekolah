<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Pengguna; // <-- UBAH INI dari User menjadi Pengguna
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\View\View;

class RegisteredUserController extends Controller
{
    /**
     * Display the registration view.
     */
    public function create(): View
    {
        return view('auth.register');
    }

    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request): RedirectResponse
    {
        // Bagian Validasi
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:50', 'unique:'.Pengguna::class], // <-- UBAH INI
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        // Bagian Membuat Pengguna Baru
        $pengguna = Pengguna::create([
            'nama_lengkap' => $request->name,
            'username' => $request->username, // <-- UBAH INI
            'password' => Hash::make($request->password),
            'role' => 'siswa', // <-- TAMBAHKAN INI (Setiap pendaftar otomatis jadi siswa)
        ]);

        event(new Registered($pengguna));

        Auth::login($pengguna);

        return redirect(route('dashboard', absolute: false));
    }
}