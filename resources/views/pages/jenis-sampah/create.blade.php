<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Tambah Jenis Sampah') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                <form action="{{ route('jenis-sampah.store') }}" method="POST">
                    @csrf
                    {{-- MODIFIKASI: Mengubah grid menjadi 4 kolom untuk layout yang lebih baik --}}
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                        <div class="md:col-span-1">
                            <x-input-label for="nama_sampah" value="Nama Sampah" />
                            <x-text-input id="nama_sampah" class="block mt-1 w-full" type="text" name="nama_sampah" :value="old('nama_sampah')" required autofocus />
                            <x-input-error :messages="$errors->get('nama_sampah')" class="mt-2" />
                        </div>
                        <div class="md:col-span-1">
    <x-input-label for="kategori" :value="__('Kategori Sampah')" />
    <select id="kategori" name="kategori" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm">
        <option value="Siswa" {{ old('kategori') == 'Siswa' ? 'selected' : '' }}>Siswa (Untuk Setoran)</option>
        <option value="Pengelola" {{ old('kategori') == 'Pengelola' ? 'selected' : '' }}>Pengelola (Internal)</option>
    </select>
    <x-input-error :messages="$errors->get('kategori')" class="mt-2" />
</div>
                        <div class="md:col-span-1">
                            <x-input-label for="satuan" value="Satuan" />
                            <select name="satuan" id="satuan" class="block mt-1 w-full border-gray-300 rounded-md shadow-sm" required>
                                <option value="pcs" {{ old('satuan') == 'pcs' ? 'selected' : '' }}>Pcs (Buah)</option>
                                <option value="kg" {{ old('satuan') == 'kg' ? 'selected' : '' }}>Kg (Kilogram)</option>
                            </select>
                            <x-input-error :messages="$errors->get('satuan')" class="mt-2" />
                        </div>
                        <div class="md:col-span-1">
                            <x-input-label for="harga_per_satuan" value="Harga Beli (dari Siswa)" />
                            <x-text-input id="harga_per_satuan" class="block mt-1 w-full" type="number" name="harga_per_satuan" :value="old('harga_per_satuan')" required />
                            <x-input-error :messages="$errors->get('harga_per_satuan')" class="mt-2" />
                        </div>
                        {{-- BARU: Menambahkan input untuk Harga Jual --}}
                        <div class="md:col-span-1">
                            <x-input-label for="harga_jual" value="Harga Jual (ke Pengepul)" />
                            <x-text-input id="harga_jual" class="block mt-1 w-full" type="number" name="harga_jual" :value="old('harga_jual')" required />
                            <x-input-error :messages="$errors->get('harga_jual')" class="mt-2" />
                        </div>
                    </div>
                    <div class="flex items-center justify-end mt-4">
                        <x-primary-button>{{ __('Simpan') }}</x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>