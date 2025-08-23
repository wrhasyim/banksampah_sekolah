<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Edit Data Siswa') }}
        </h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('siswa.update', $siswa->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div>
                            <x-input-label for="nama_lengkap" value="Nama Lengkap" />
                            <x-text-input id="nama_lengkap" class="block mt-1 w-full" type="text" name="nama_lengkap" :value="old('nama_lengkap', $siswa->pengguna->nama_lengkap)" required autofocus />
                            <x-input-error :messages="$errors->get('nama_lengkap')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="username" value="Username" />
                            <x-text-input id="username" class="block mt-1 w-full" type="text" name="username" :value="old('username', $siswa->pengguna->username)" required />
                            <x-input-error :messages="$errors->get('username')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="password" value="Password Baru (Kosongkan jika tidak diubah)" />
                            <x-text-input id="password" class="block mt-1 w-full" type="password" name="password" />
                            <x-input-error :messages="$errors->get('password')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="nis" value="NIS (Nomor Induk Siswa)" />
                            <x-text-input id="nis" class="block mt-1 w-full" type="text" name="nis" :value="old('nis', $siswa->nis)" />
                            <x-input-error :messages="$errors->get('nis')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="id_kelas" value="Kelas" />
                            <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">Pilih Kelas</option>
                                @foreach ($kelas as $item)
                                    <option value="{{ $item->id }}" {{ $siswa->id_kelas == $item->id ? 'selected' : '' }}>
                                        {{ $item->nama_kelas }}
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('id_kelas')" class="mt-2" />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ms-4">
                                {{ __('Update') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>