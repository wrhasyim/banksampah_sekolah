<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Tambah Data Siswa') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('siswa.store') }}" method="POST">
                        @csrf
                        {{-- Nama Lengkap --}}
                        <div>
                            {{-- PERBAIKAN: Mengubah nama input dari 'nama_lengkap' menjadi 'nama' --}}
                            <x-input-label for="nama" value="Nama Lengkap" />
                            <x-text-input id="nama" class="block mt-1 w-full" type="text" name="nama" :value="old('nama')" required autofocus />
                            <x-input-error :messages="$errors->get('nama')" class="mt-2" />
                        </div>
                        {{-- NIS --}}
                        <div class="mt-4">
                            <x-input-label for="nis" value="NIS (Nomor Induk Siswa)" />
                            <x-text-input id="nis" class="block mt-1 w-full" type="text" name="nis" :value="old('nis')" />
                             <x-input-error :messages="$errors->get('nis')" class="mt-2" />
                        </div>
                         {{-- Kelas --}}
                        <div class="mt-4">
                            <x-input-label for="id_kelas" value="Kelas" />
                            <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 rounded-md shadow-sm" required>
                                @foreach($kelas as $item)
                                    <option value="{{ $item->id }}" {{ old('id_kelas') == $item->id ? 'selected' : '' }}>{{ $item->nama_kelas }}</option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('id_kelas')" class="mt-2" />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button>
                                {{ __('Simpan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>