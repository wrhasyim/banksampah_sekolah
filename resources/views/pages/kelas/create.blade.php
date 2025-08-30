<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Tambah Kelas Baru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <form action="{{ route('kelas.store') }}" method="POST">
                        @csrf
                        <div class="mb-4">
                            <label for="nama_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nama Kelas</label>
                            <input type="text" id="nama_kelas" name="nama_kelas" value="{{ old('nama_kelas') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
                            @error('nama_kelas') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
                        </div>

                        {{-- --- TAMBAHAN DROPDOWN WALI KELAS --- --}}
                        <div class="mb-4">
                            <label for="id_wali_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Wali Kelas (Opsional)</label>
                            <select id="id_wali_kelas" name="id_wali_kelas" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                                <option value="">-- Tidak Ada --</option>
                                @foreach ($waliKelasOptions as $wali)
                                    <option value="{{ $wali->id }}" {{ old('id_wali_kelas') == $wali->id ? 'selected' : '' }}>{{ $wali->nama_lengkap }}</option>
                                @endforeach
                            </select>
                            @error('id_wali_kelas') <p class="mt-2 text-sm text-red-600">{{ $message }}</p> @enderror
                        </div>

                        <div class="flex items-center justify-end mt-4">
                             <a href="{{ route('kelas.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">Batal</a>
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>