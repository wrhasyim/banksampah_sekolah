<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Edit Siswa') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    
                    {{-- Form akan dikirim ke route 'siswa.update' dengan method PUT --}}
                    <form action="{{ route('siswa.update', $siswa->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            
                            <div>
                                <x-input-label for="nama_lengkap" :value="__('Nama Lengkap')" />
                                <x-text-input id="nama_lengkap" class="block mt-1 w-full" type="text" name="nama_lengkap" :value="old('nama_lengkap', $siswa->pengguna->nama_lengkap)" required autofocus />
                                <x-input-error :messages="$errors->get('nama_lengkap')" class="mt-2" />
                            </div>

                            <div>
                                <x-input-label for="nis" :value="__('NIS')" />
                                <x-text-input id="nis" class="block mt-1 w-full" type="text" name="nis" :value="old('nis', $siswa->nis)" required />
                                <x-input-error :messages="$errors->get('nis')" class="mt-2" />
                            </div>

                            <div>
                                <x-input-label for="username" :value="__('Username')" />
                                <x-text-input id="username" class="block mt-1 w-full" type="text" name="username" :value="old('username', $siswa->pengguna->username)" required />
                                <x-input-error :messages="$errors->get('username')" class="mt-2" />
                            </div>

                            <div>
                                <x-input-label for="password" :value="__('Password (Opsional)')" />
                                <x-text-input id="password" class="block mt-1 w-full" type="password" name="password" />
                                <small class="text-gray-500">Kosongkan jika tidak ingin mengubah password.</small>
                                <x-input-error :messages="$errors->get('password')" class="mt-2" />
                            </div>

                            <div>
                                <x-input-label for="id_kelas" :value="__('Kelas')" />
                                <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm">
                                    @foreach ($kelas as $item)
                                        <option value="{{ $item->id }}" {{ old('id_kelas', $siswa->id_kelas) == $item->id ? 'selected' : '' }}>
                                            {{ $item->nama_kelas }}
                                        </option>
                                    @endforeach
                                </select>
                                <x-input-error :messages="$errors->get('id_kelas')" class="mt-2" />
                            </div>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button>
                                {{ __('Update') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>