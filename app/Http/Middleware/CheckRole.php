<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckRole
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  string  $roles String yang berisi daftar peran yang diizinkan, dipisah koma.
     */
    public function handle(Request $request, Closure $next, string $roles): Response
    {
        // 1. Ambil peran user yang sedang login
        $userRole = $request->user()->role;

        // 2. Ubah string $roles (misal "admin,wali,siswa") menjadi array
        $allowedRoles = explode(',', $roles);

        // 3. Trim spasi jika ada (misal dari "admin, wali")
        $allowedRoles = array_map('trim', $allowedRoles);

        // 4. Periksa apakah peran user ada di dalam daftar peran yang diizinkan
        if (!in_array($userRole, $allowedRoles)) {
            // 5. Jika tidak diizinkan, lempar error 403
            abort(403, 'ANDA TIDAK MEMILIKI AKSES KE HALAMAN INI.');
        }

        // 6. Jika diizinkan, lanjutkan request ke controller
        return $next($request);
    }
}