<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Buat Setoran Baru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <form action="{{ route('setoran.store') }}" method="POST">
                        @csrf
                        {{-- PERBAIKAN: Menggunakan @forelse untuk menangani jika data kosong --}}
                        <div class="mb-4">
                            <label for="id_siswa" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Siswa</label>
                            <select id="id_siswa" name="id_siswa" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                <option value="" disabled selected>-- Pilih Siswa --</option>
                                @forelse($siswas as $siswa)
                                    <option value="{{ $siswa->id }}">{{ $siswa->nama }}</option>
                                @empty
                                    <option value="" disabled>Tidak ada data siswa ditemukan</option>
                                @endforelse
                            </select>
                            @error('id_siswa')
                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                            @enderror
                        </div>
                        
                        {{-- PERBAIKAN: Menggunakan @forelse untuk menangani jika data kosong --}}
                        <div class="mb-4">
                            <label for="id_jenis_sampah" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jenis Sampah</label>
                            <select id="id_jenis_sampah" name="id_jenis_sampah" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                <option value="" disabled selected>-- Pilih Jenis Sampah --</option>
                                @forelse($jenisSampah as $item)
                                    <option value="{{ $item->id }}" data-harga="{{ $item->harga }}">{{ $item->nama }}</option>
                                @empty
                                    <option value="" disabled>Tidak ada data jenis sampah ditemukan</option>
                                @endforelse
                            </select>
                             @error('id_jenis_sampah')
                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                            @enderror
                        </div>
                        
                        <div class="mb-4">
                            <label for="berat" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Berat (kg)</label>
                            <input type="number" id="berat" name="berat" step="0.01" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                             @error('berat')
                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                            @enderror
                        </div>
                        <div class="flex items-center justify-end mt-4">
                             <a href="{{ route('setoran.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">
                                Batal
                            </a>
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">
                                Simpan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>