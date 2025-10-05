<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Formulir Pemberian Reward') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-6 text-lg font-medium text-gray-900 dark:text-gray-100">
                        Berikan Reward Botol
                    </h3>

                    <form action="{{ route('rewards.store') }}" method="POST">
                        @csrf
                        
                        {{-- PERBAIKAN UTAMA: Kolom Pencarian Siswa (AJAX) --}}
                        <div>
                            <x-input-label for="siswa-select" :value="__('Cari Nama Siswa')" />
                            {{-- Nama diubah ke 'siswa_id' dan select dikosongkan --}}
                            <select id="siswa-select" name="siswa_id" required style="width: 100%;"></select>
                            <x-input-error :messages="$errors->get('siswa_id')" class="mt-2" />
                        </div>

                        {{-- Input Jumlah Botol --}}
                        <div class="mt-4">
                            <x-input-label for="quantity" :value="__('Jumlah Botol')" />
                            <x-text-input id="quantity" class="block w-full mt-1" type="number" name="quantity" :value="old('quantity')" required min="1" />
                            <x-input-error :messages="$errors->get('quantity')" class="mt-2" />
                        </div>

                        <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
                            Estimasi Biaya: <span id="estimasi-biaya" class="font-semibold">Rp 0</span>
                        </div>
                        
                        {{-- Keterangan Opsional (Dihilangkan untuk menyederhanakan, bisa ditambahkan kembali jika perlu) --}}
                        {{-- <div class="mt-4"> ... </div> --}}

                        {{-- Tombol Aksi --}}
                        <div class="flex items-center justify-end mt-6">
                            <a href="{{ route('rewards.index') }}">
                                <x-secondary-button type="button">
                                    {{ __('Batal') }}
                                </x-secondary-button>
                            </a>
                            <x-primary-button class="ms-4">
                                {{ __('Simpan Reward') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        // Gunakan $(document).ready() karena kita memakai jQuery untuk Select2
        $(document).ready(function() {
            // Inisialisasi Fitur Pencarian Nama Siswa (AJAX) dengan Select2
            $('#siswa-select').select2({
                placeholder: "Ketik nama siswa untuk mencari...",
                minimumInputLength: 2,
                ajax: {
                    url: "{{ route('select.siswa') }}", // Menggunakan kembali route pencarian
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return { search: params.term };
                    },
                    processResults: function (data) {
                        return { results: data };
                    },
                    cache: true
                }
            });

            // Inisialisasi Kalkulator Biaya Otomatis (fungsi lain tetap aman)
            const hargaPerBotol = {{ $hargaPerBotol ?? 0 }};
            const quantityInput = document.getElementById('quantity');
            const estimasiBiayaEl = document.getElementById('estimasi-biaya');

            quantityInput.addEventListener('input', function() {
                const quantity = parseInt(this.value) || 0;
                const totalBiaya = quantity * hargaPerBotol;
                estimasiBiayaEl.textContent = 'Rp ' + totalBiaya.toLocaleString('id-ID');
            });
        });
    </script>
    @endpush
</x-app-layout>