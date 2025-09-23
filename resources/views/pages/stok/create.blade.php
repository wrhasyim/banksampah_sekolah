<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{-- Judul dinamis berdasarkan data yang dikirim --}}
            {{ isset($jenisSampah) ? 'Stok Masuk untuk: ' . $jenisSampah->nama_sampah : 'Stok Masuk' }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                <form action="{{ route('stok.store') }}" method="POST">
                    @csrf

                    {{-- Jika jenis sampah sudah ditentukan dari halaman sebelumnya --}}
                    @if(isset($jenisSampah))
                        <input type="hidden" name="jenis_sampah_id" value="{{ $jenisSampah->id }}">
                    @else
                    {{-- Jika belum, tampilkan dropdown untuk memilih --}}
                        <div class="mb-4">
                            <x-input-label for="jenis_sampah_id" value="Pilih Jenis Sampah" />
                            <select name="jenis_sampah_id" id="jenis_sampah_id" class="block mt-1 w-full border-gray-300 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Sampah --</option>
                                @foreach($semuaJenisSampah as $item)
                                    <option value="{{ $item->id }}">{{ $item->nama_sampah }} ({{ $item->kategori }})</option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('jenis_sampah_id')" class="mt-2" />
                        </div>
                    @endif

                    {{-- Input Jumlah Stok --}}
                    <div class="mb-4">
                        <x-input-label for="jumlah">
                            Jumlah Stok Masuk (Satuan: {{ $jenisSampah->satuan ?? '...' }})
                        </x-input-label>
                        <x-text-input id="jumlah" class="block mt-1 w-full" type="number" step="0.01" name="jumlah" :value="old('jumlah')" required autofocus />
                        <x-input-error :messages="$errors->get('jumlah')" class="mt-2" />
                    </div>
                    
                    {{-- Keterangan (Opsional) --}}
                    <div class="mb-4">
                        <x-input-label for="keterangan" value="Keterangan (Opsional)" />
                        <textarea name="keterangan" id="keterangan" rows="3" class="block mt-1 w-full border-gray-300 rounded-md shadow-sm">{{ old('keterangan', 'Stok masuk manual') }}</textarea>
                    </div>

                    <div class="flex items-center justify-end mt-4">
                        <a href="{{ route('jenis-sampah.index') }}" class="text-gray-600 hover:text-gray-900 mr-4">Batal</a>
                        <x-primary-button>
                            {{ __('Simpan Stok') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>