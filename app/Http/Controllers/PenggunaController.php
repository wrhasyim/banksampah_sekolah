<?php

namespace App\Http\Controllers;

use App\Models\Pengguna;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class PenggunaController extends Controller
{
    public function index()
    {
        $penggunas = Pengguna::where('role', '!=', 'siswa')->latest()->get();
        return view('pages.pengguna.index', compact('penggunas'));
    }

    public function create()
    {
        return view('pages.pengguna.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:pengguna,username',
            'password' => 'required|string|min:8|confirmed',
            'role' => ['required', Rule::in(['admin', 'wali'])],
        ]);

        Pengguna::create([
            'nama_lengkap' => $request->nama_lengkap,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'role' => $request->role,
        ]);

        return redirect()->route('pengguna.index')->with('toastr-success', 'Pengguna berhasil ditambahkan.');
    }

    public function edit(Pengguna $pengguna)
    {
        return view('pages.pengguna.edit', compact('pengguna'));
    }

    public function update(Request $request, Pengguna $pengguna)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:pengguna,username,' . $pengguna->id,
            'role' => ['required', Rule::in(['admin', 'wali'])],
            'password' => 'nullable|string|min:8|confirmed',
        ]);

        $pengguna->nama_lengkap = $request->nama_lengkap;
        $pengguna->username = $request->username;
        $pengguna->role = $request->role;

        if ($request->filled('password')) {
            $pengguna->password = Hash::make($request->password);
        }

        $pengguna->save();

        return redirect()->route('pengguna.index')->with('toastr-success', 'Pengguna berhasil diperbarui.');
    }

    public function destroy(Pengguna $pengguna)
    {
        if ($pengguna->id === Auth::id()) {
            return redirect()->route('pengguna.index')->with('toastr-error', 'Anda tidak dapat menghapus akun Anda sendiri.');
        }

        $pengguna->delete();

        return redirect()->route('pengguna.index')->with('toastr-success', 'Pengguna berhasil dihapus.');
    }
}