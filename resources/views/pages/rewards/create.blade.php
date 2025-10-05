<x-app-layout>
    {{-- Header dihilangkan sesuai permintaan --}}

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-6">
                        Formulir Pemberian Reward
                    </h3>

                    <form action="{{ route('rewards.store') }}" method="POST">
                        @csrf
                        
                        <div>
                            <x-input-label for="select-siswa" :value="__('Cari Nama Siswa')" />
                            <select id="select-siswa" name="user_id" placeholder="Ketik untuk mencari nama siswa..." autocomplete="off" required>
                                <option value="">-- Pilih Siswa --</option>
                                @foreach ($siswas as $siswa)
                                    <option value="{{ $siswa->id }}" {{ old('user_id') == $siswa->id ? 'selected' : '' }}>
                                        {{ $siswa->nama_lengkap }}
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('user_id')" class="mt-2" />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="quantity" :value="__('Jumlah Botol')" />
                            <x-text-input id="quantity" class="block mt-1 w-full" type="number" name="quantity" :value="old('quantity')" required min="1" />
                            <x-input-error :messages="$errors->get('quantity')" class="mt-2" />
                        </div>

                        <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
                            Estimasi Biaya: <span id="estimasi-biaya" class="font-semibold">Rp 0</span>
                        </div>
                        
                        <div class="mt-4">
                            <x-input-label for="description" :value="__('Keterangan (Opsional)')" />
                            <textarea id="description" name="description" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm" rows="3">{{ old('description') }}</textarea>
                            <x-input-error :messages="$errors->get('description')" class="mt-2" />
                        </div>

                        <div class="flex items-center justify-end mt-6">
                            <a href="{{ route('rewards.index') }}">
                                <x-secondary-button>
                                    {{ __('Batal') }}
                                </x-secondary-button>
                            </a>
                            <x-primary-button class="ml-4">
                                {{ __('Simpan') }}
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
            // Inisialisasi Fitur Pencarian Nama Siswa
            new TomSelect('#select-siswa',{
                create: false,
                sortField: {
                    field: "text",
                    direction: "asc"
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