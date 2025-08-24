<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Tarik Seluruh Saldo Kelas') }}
        </h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if (session('error'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('error') }}</span>
                        </div>
                    @endif

                    <div class="mb-4 p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700">
                        <p class="font-bold">Perhatian!</p>
                        <p>Tindakan ini akan menarik **seluruh sisa saldo** dari **semua siswa** di kelas yang dipilih. Saldo mereka akan menjadi Rp 0. Pastikan Anda sudah yakin sebelum melanjutkan.</p>
                    </div>

                    <form action="{{ route('penarikan.storeKelas') }}" method="POST" onsubmit="return confirm('Anda yakin ingin menarik seluruh saldo dari kelas ini? Tindakan ini tidak dapat dibatalkan.');">
                        @csrf
                        <div class="mt-4">
                            <x-input-label for="id_kelas" value="Pilih Kelas" />
                            <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Kelas (Total Saldo) --</option>
                                @foreach ($kelas as $item)
                                    <option value="{{ $item->id }}" {{ old('id_kelas') == $item->id ? 'selected' : '' }}>
                                        {{ $item->nama_kelas }} (Total Saldo: Rp {{ number_format($item->siswa->sum('saldo'), 0, ',', '.') }})
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('id_kelas')" class="mt-2" />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ms-4 bg-red-600 hover:bg-red-700">
                                {{ __('Ya, Tarik Seluruh Saldo Kelas Ini') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>