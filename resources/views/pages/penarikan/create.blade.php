<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Formulir Penarikan Saldo') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-6 text-lg font-medium text-gray-900 dark:text-gray-100">
                        Buat Permintaan Penarikan Baru
                    </h3>

                    <form action="{{ route('penarikan.store') }}" method="POST">
                        @csrf
                        
                        {{-- PERBAIKAN UTAMA DI SINI --}}
                        <div>
                            <x-input-label for="siswa-select" :value="__('Cari Nama Siswa')" />
                            {{-- Kosongkan @foreach dan biarkan select kosong --}}
                            <select id="siswa-select" name="siswa_id" required style="width: 100%;"></select>
                            <x-input-error :messages="$errors->get('siswa_id')" class="mt-2" />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="jumlah_penarikan" :value="__('Jumlah Penarikan')" />
                            <x-text-input id="jumlah_penarikan" class="block w-full mt-1" type="number" name="jumlah_penarikan" :value="old('jumlah_penarikan')" required min="1" />
                            <x-input-error :messages="$errors->get('jumlah_penarikan')" class="mt-2" />
                        </div>

                        <div class="flex items-center justify-end mt-6">
                            <a href="{{ route('penarikan.index') }}">
                                <x-secondary-button type="button">
                                    {{ __('Batal') }}
                                </x-secondary-button>
                            </a>
                            <x-primary-button class="ms-4">
                                {{ __('Ajukan Penarikan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    {{-- Script untuk inisialisasi Select2 dengan AJAX --}}
    @push('scripts')
    <script>
        $(document).ready(function() {
            $('#siswa-select').select2({
                placeholder: "Ketik nama siswa untuk mencari...",
                minimumInputLength: 2, // Mulai mencari setelah 2 karakter
                ajax: {
                    url: "{{ route('select.siswa') }}",
                    dataType: 'json',
                    delay: 250, // Jeda sebelum request dikirim
                    data: function (params) {
                        return {
                            search: params.term, // Kata kunci pencarian
                        };
                    },
                    processResults: function (data) {
                        return {
                            results: data
                        };
                    },
                    cache: true
                }
            });
        });
    </script>
    @endpush
</x-app-layout>