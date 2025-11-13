<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth; // <-- Tambahkan ini

class CheckRole
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  ...string  $roles  // <-- PERUBAHAN UTAMA DI SINI
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        // 1. (Perbaikan) Cek dulu apakah user sudah login
        if (!Auth::check()) {
            return redirect()->route('login'); // Arahkan ke login jika belum
        }

        // 2. Ambil peran user yang sedang login
        $userRole = $request->user()->role; // atau Auth::user()->role

        // 3. (Perbaikan) Cek apakah peran user ada di dalam array $roles
        // Karena $roles sekarang otomatis menjadi array (misal: ['admin', 'wali', 'siswa'])
        // kita tidak perlu lagi menggunakan explode() atau trim().
        if (!in_array($userRole, $roles)) {
            
            // 4. Jika tidak diizinkan, lempar error 403
            abort(403, 'ANDA TIDAK MEMILIKI AKSES KE HALAMAN INI.');
        }

        // 5. Jika diizinkan, lanjutkan request
        return $next($request);
    }
}