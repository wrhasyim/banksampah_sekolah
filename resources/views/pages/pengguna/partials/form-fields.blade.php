<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div>
        <label for="nama_lengkap" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nama Lengkap</label>
        <input type="text" id="nama_lengkap" name="nama_lengkap" value="{{ old('nama_lengkap', $pengguna->nama_lengkap ?? '') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
        @error('nama_lengkap') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
    </div>
    <div>
        <label for="username" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Username</label>
        <input type="text" id="username" name="username" value="{{ old('username', $pengguna->username ?? '') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
        @error('username') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
    </div>
    <div>
        <label for="role" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Role</label>
        <select id="role" name="role" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
            <option value="admin" {{ old('role', $pengguna->role ?? '') == 'admin' ? 'selected' : '' }}>Admin</option>
            <option value="wali" {{ old('role', $pengguna->role ?? '') == 'wali' ? 'selected' : '' }}>Wali Kelas</option>
        </select>
        @error('role') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
    </div>
    <div class="md:col-span-2"><hr class="dark:border-gray-600"></div>
    <div>
        <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Password</label>
        <input type="password" id="password" name="password" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" {{ isset($pengguna) ? '' : 'required' }}>
        @if(isset($pengguna)) <p class="mt-1 text-xs text-gray-500">Kosongkan jika tidak ingin mengubah password.</p> @endif
        @error('password') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
    </div>
    <div>
        <label for="password_confirmation" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Konfirmasi Password</label>
        <input type="password" id="password_confirmation" name="password_confirmation" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
    </div>
</div>