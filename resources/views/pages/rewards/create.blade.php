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
                        
                        {{-- Kolom Pencarian Siswa (AJAX) --}}
                        <div>
                            <x-input-label for="user-select" :value="__('Cari Nama Siswa')" />
                            {{-- Nama input adalah user_id --}}
                            <select id="user-select" name="user_id" required style="width: 100%;"></select>
                            <x-input-error :messages="$errors->get('user_id')" class="mt-2" />
                        </div>

                        {{-- Input Jumlah Botol --}}
                        <div class="mt-4">
                            <x-input-label for="quantity" :value="__('Jumlah Botol')" />
                            <x-text-input id="quantity" class="block w-full mt-1" type="number" name="quantity" :value="old('quantity')" required min="1" />
                            <x-input-error :messages="$errors->get('quantity')" class="mt-2" />
                        </div>

                        <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
                            Estimasi Nilai Reward: <span id="estimasi-biaya" class="font-semibold">Rp 0</span>
                        </div>
                        
                        <div class="mt-4">
                            <x-input-label for="description" :value="__('Keterangan (Opsional)')" />
                            <textarea id="description" name="description" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm" rows="3">{{ old('description') }}</textarea>
                            <x-input-error :messages="$errors->get('description')" class="mt-2" />
                        </div>

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
        $(document).ready(function() {
            // Inisialisasi Fitur Pencarian Nama Siswa (AJAX)
            $('#user-select').select2({
                placeholder: "Ketik nama siswa untuk mencari...",
                minimumInputLength: 2,
                ajax: {
                    url: "{{ route('select.siswa') }}",
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return { search: params.term };
                    },
                    processResults: function (data) {
                        // --- PERBAIKAN PENTING DI SINI ---
                        // Proses data agar Select2 dapat membacanya dengan benar
                        return {
                            results: $.map(data, function(item) {
                                return {
                                    // 'id' yang akan dikirim oleh form adalah user_id dari data AJAX
                                    id: item.user_id, 
                                    text: item.text
                                }
                            })
                        };
                    },
                    cache: true
                }
            });

            // Inisialisasi Kalkulator Biaya Otomatis
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