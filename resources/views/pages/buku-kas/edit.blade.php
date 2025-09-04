<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Edit Transaksi Buku Kas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <form action="{{ route('buku-kas.update', $bukuKas->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <x-input-label for="tanggal" :value="__('Tanggal')" />
                                <x-text-input id="tanggal" class="block mt-1 w-full" type="date" name="tanggal" :value="old('tanggal', $bukuKas->tanggal)" required />
                            </div>
                             <div>
                                <x-input-label for="id_kategori" :value="__('Kategori (Opsional)')" />
                                <select name="id_kategori" id="id_kategori_edit" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm">
                                    <option value="">-- Tanpa Kategori --</option>
                                    @foreach($kategoriTransaksi as $kategori)
                                        <option value="{{ $kategori->id }}" data-tipe="{{ $kategori->tipe }}" {{ $bukuKas->id_kategori == $kategori->id ? 'selected' : '' }}>
                                            {{ $kategori->nama_kategori }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div>
                                <x-input-label for="tipe" :value="__('Tipe Transaksi')" />
                                <select name="tipe" id="tipe_edit" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm">
                                    <option value="pemasukan" {{ $bukuKas->tipe == 'pemasukan' ? 'selected' : '' }}>Pemasukan</option>
                                    <option value="pengeluaran" {{ $bukuKas->tipe == 'pengeluaran' ? 'selected' : '' }}>Pengeluaran</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-4">
                            <x-input-label for="deskripsi" :value="__('Deskripsi')" />
                            <x-text-input id="deskripsi" class="block mt-1 w-full" type="text" name="deskripsi" :value="old('deskripsi', $bukuKas->deskripsi)" required />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="jumlah" :value="__('Jumlah (Rp)')" />
                            <x-text-input id="jumlah" class="block mt-1 w-full" type="number" name="jumlah" :value="old('jumlah', $bukuKas->jumlah)" required />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                             <a href="{{ route('buku-kas.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-200 dark:bg-gray-600 border border-transparent rounded-md font-semibold text-xs text-gray-800 dark:text-gray-200 uppercase tracking-widest hover:bg-gray-300 dark:hover:bg-gray-500">
                                {{ __('Batal') }}
                            </a>
                            <x-primary-button class="ml-4">
                                {{ __('Simpan Perubahan') }}
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
            const kategoriSelect = document.getElementById('id_kategori_edit');
            const tipeSelect = document.getElementById('tipe_edit');

            function toggleTipe() {
                const selectedOption = kategoriSelect.options[kategoriSelect.selectedIndex];
                const tipe = selectedOption.getAttribute('data-tipe');

                if (tipe) {
                    tipeSelect.value = tipe;
                    tipeSelect.disabled = true;
                } else {
                    tipeSelect.disabled = false;
                }
            }

            // Jalankan saat halaman dimuat
            toggleTipe(); 

            // Jalankan saat pilihan kategori berubah
            kategoriSelect.addEventListener('change', toggleTipe);
        });
    </script>
    @endpush
</x-app-layout>