<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Edit Transaksi Kas') }}</h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <form action="{{ route('buku-kas.update', $bukuKa->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div>
                            <x-input-label for="tanggal" value="Tanggal Transaksi" />
                            <x-text-input id="tanggal" class="block mt-1 w-full" type="date" name="tanggal" :value="old('tanggal', $bukuKa->tanggal)" required />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="deskripsi" value="Deskripsi" />
                            <x-text-input id="deskripsi" class="block mt-1 w-full" type="text" name="deskripsi" :value="old('deskripsi', $bukuKa->deskripsi)" required />
                        </div>
                        
                        {{-- Dropdown Tipe Transaksi Dihapus --}}

                         <div class="mt-4">
                                <x-input-label for="id_kategori" value="Kategori" />
                                <select name="id_kategori" id="id_kategori" class="block mt-1 w-full border-gray-300 rounded-md" required>
                                    <option value="">-- Pilih Kategori --</option>
                                    @foreach ($kategori as $kat)
                                        <option value="{{ $kat->id }}" {{ $bukuKa->id_kategori == $kat->id ? 'selected' : '' }}>{{ $kat->nama_kategori }} ({{ ucfirst($kat->tipe) }})</option>
                                    @endforeach
                                </select>
                            </div>
                        <div class="mt-4">
                            <x-input-label for="jumlah" value="Jumlah (Rp)" />
                            <x-text-input id="jumlah" class="block mt-1 w-full" type="number" name="jumlah" :value="old('jumlah', $bukuKa->jumlah)" required />
                        </div>
                        <div class="flex justify-end mt-4">
                            <x-primary-button>{{ __('Update') }}</x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>