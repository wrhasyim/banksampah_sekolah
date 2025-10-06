<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Buat Penarikan Saldo') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-6">
                        Formulir Penarikan Saldo
                    </h3>

                    <form action="{{ route('penarikan.store') }}" method="POST">
                        @csrf
                        
                        <div class="mt-4">
                            <x-input-label for="select-siswa-penarikan" :value="__('Cari Nama Siswa')" />
                            <select id="select-siswa-penarikan" name="siswa_id" placeholder="Ketik untuk mencari nama siswa..." autocomplete="off" required>
                                <option value="">-- Pilih Siswa --</option>
                                @foreach ($siswas as $siswa)
                                    <option value="{{ $siswa->id }}" {{ old('siswa_id') == $siswa->id ? 'selected' : '' }}>
                                        {{ $siswa->pengguna->nama_lengkap }} (Saldo: Rp {{ number_format($siswa->saldo, 0, ',', '.') }})
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('siswa_id')" class="mt-2" />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="jumlah_penarikan" :value="__('Jumlah Penarikan')" />
                            <x-text-input id="jumlah_penarikan" class="block mt-1 w-full" type="number" name="jumlah_penarikan" :value="old('jumlah_penarikan')" required min="1" />
                            <x-input-error :messages="$errors->get('jumlah_penarikan')" class="mt-2" />
                        </div>

                        <div class="flex items-center justify-end mt-6">
                            <a href="{{ route('penarikan.index') }}">
                                <x-secondary-button>
                                    {{ __('Batal') }}
                                </x-secondary-button>
                            </a>
                            <x-primary-button class="ml-4">
                                {{ __('Ajukan Penarikan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            new TomSelect('#select-siswa-penarikan',{
                create: false,
                sortField: {
                    field: "text",
                    direction: "asc"
                }
            });
        });
    </script>
    @endpush
</x-app-layout>