<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Catat Penarikan Baru') }}
        </h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if (session('error'))
                        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                            <span class="block sm:inline">{{ session('error') }}</span>
                        </div>
                    @endif
                    <form action="{{ route('penarikan.store') }}" method="POST">
                        @csrf
                        <div class="mt-4">
                            <x-input-label for="id_siswa" value="Pilih Siswa" />
                            <select name="id_siswa" id="id_siswa" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Siswa (Saldo Saat Ini) --</option>
                                @foreach ($siswa as $item)
                                    <option value="{{ $item->id }}">
                                        {{ $item->pengguna->nama_lengkap }} (Rp {{ number_format($item->saldo, 0, ',', '.') }})
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('id_siswa')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="jumlah_penarikan" value="Jumlah Penarikan (Rp)" />
                            <x-text-input id="jumlah_penarikan" class="block mt-1 w-full" type="number" name="jumlah_penarikan" :value="old('jumlah_penarikan')" required />
                            <x-input-error :messages="$errors->get('jumlah_penarikan')" class="mt-2" />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ms-4">
                                {{ __('Simpan Transaksi') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>