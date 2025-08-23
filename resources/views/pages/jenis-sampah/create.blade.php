<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Tambah Jenis Sampah') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('jenis-sampah.store') }}" method="POST">
                        @csrf
                        <div>
                            <x-input-label for="nama_sampah" :value="__('Nama Sampah')" />
                            <x-text-input id="nama_sampah" class="block mt-1 w-full" type="text" name="nama_sampah" :value="old('nama_sampah')" required autofocus />
                            <x-input-error :messages="$errors->get('nama_sampah')" class="mt-2" />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="harga_per_satuan" :value="__('Harga per Satuan (Rp)')" />
                            <x-text-input id="harga_per_satuan" class="block mt-1 w-full" type="number" name="harga_per_satuan" :value="old('harga_per_satuan')" required />
                            <x-input-error :messages="$errors->get('harga_per_satuan')" class="mt-2" />
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ms-4">
                                {{ __('Simpan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>