<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Edit Jenis Sampah') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                <form action="{{ route('jenis-sampah.update', $jenisSampah->id) }}" method="POST">
                    @csrf
                    @method('PUT')
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        {{-- Nama Sampah --}}
                        <div>
                            <x-input-label for="nama_sampah" value="Nama Sampah" />
                            {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                            <x-text-input id="nama_sampah" class="block mt-1 w-full" type="text" name="nama_sampah" :value="old('nama_sampah', $jenisSampah->nama_sampah)" required autofocus />
                            <x-input-error :messages="$errors->get('nama_sampah')" class="mt-2" />
                        </div>

                        {{-- Kategori Sampah (BARU) --}}
                        <div>
                            <x-input-label for="kategori" value="Kategori Sampah" />
                            <select id="kategori" name="kategori" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm">
                                {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                                <option value="Siswa" {{ old('kategori', $jenisSampah->kategori) == 'Siswa' ? 'selected' : '' }}>Siswa (Untuk Setoran)</option>
                                <option value="Pengelola" {{ old('kategori', $jenisSampah->kategori) == 'Pengelola' ? 'selected' : '' }}>Pengelola (Internal)</option>
                            </select>
                            <x-input-error :messages="$errors->get('kategori')" class="mt-2" />
                        </div>

                        {{-- Satuan --}}
                        <div>
                            <x-input-label for="satuan" value="Satuan" />
                            <select name="satuan" id="satuan" class="block mt-1 w-full border-gray-300 rounded-md shadow-sm" required>
                                {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                                <option value="pcs" {{ old('satuan', $jenisSampah->satuan) == 'pcs' ? 'selected' : '' }}>Pcs (Buah)</option>
                                <option value="kg" {{ old('satuan', $jenisSampah->satuan) == 'kg' ? 'selected' : '' }}>Kg (Kilogram)</option>
                            </select>
                            <x-input-error :messages="$errors->get('satuan')" class="mt-2" />
                        </div>

                        {{-- Harga Beli --}}
                        <div>
                            <x-input-label for="harga_per_satuan" value="Harga Beli (dari Siswa)" />
                            {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                            <x-text-input id="harga_per_satuan" class="block mt-1 w-full" type="number" name="harga_per_satuan" :value="old('harga_per_satuan', $jenisSampah->harga_per_satuan)" required />
                            <x-input-error :messages="$errors->get('harga_per_satuan')" class="mt-2" />
                        </div>

                        {{-- Harga Jual --}}
                        <div class="md:col-span-2">
                            <x-input-label for="harga_jual" value="Harga Jual (ke Pengepul)" />
                            {{-- PERBAIKAN: Menggunakan variabel $jenisSampah --}}
                            <x-text-input id="harga_jual" class="block mt-1 w-full" type="number" name="harga_jual" :value="old('harga_jual', $jenisSampah->harga_jual)" required />
                            <x-input-error :messages="$errors->get('harga_jual')" class="mt-2" />
                        </div>
                    </div>

                    <div class="flex items-center justify-end mt-6">
                        <a href="{{ route('jenis-sampah.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-300 border border-transparent rounded-md font-semibold text-xs text-gray-700 uppercase tracking-widest hover:bg-gray-400 focus:bg-gray-400 active:bg-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150 mr-4">
                            Batal
                        </a>
                        <x-primary-button>{{ __('Update') }}</x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>