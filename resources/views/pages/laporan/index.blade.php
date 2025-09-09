<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Laporan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-semibold mb-4">Laporan Transaksi (Setoran & Penarikan)</h3>

                    <form action="{{ route('laporan.index') }}" method="GET" class="mb-4">
                        <div class="flex items-center">
                            <input type="text" name="nama_siswa" class="w-full px-3 py-2 border rounded-md" placeholder="Cari berdasarkan nama siswa..." value="{{ request('nama_siswa') }}">
                            <button type="submit" class="ml-2 px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">
                                Cari
                            </button>
                        </div>
                    </form>

                    @include('pages.laporan.partials.tabel-transaksi')
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-semibold mb-4">Laporan Penjualan</h3>
                    @include('pages.laporan.partials.tabel-penjualan')
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-semibold mb-4">Laporan Laba Rugi</h3>
                    @include('pages.laporan.partials.laporan-laba-rugi')
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const filterButtons = document.querySelectorAll('.btn-filter-jenis');
        const hiddenInput = document.getElementById('transaction_type_input');

        // Style untuk tombol aktif dan tidak aktif
        const activeClasses = 'bg-blue-600 text-white hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 border-blue-600 dark:border-blue-500';
        const inactiveClasses = 'bg-white text-gray-900 hover:bg-gray-100 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600 border-gray-200 dark:border-gray-600';

        let selectedTypes = hiddenInput.value ? hiddenInput.value.split(',') : [];

        // Inisialisasi status tombol saat halaman dimuat
        function updateButtonStates() {
            filterButtons.forEach(button => {
                const value = button.getAttribute('data-value');
                if (selectedTypes.includes(value)) {
                    button.className = button.className.replace(new RegExp(inactiveClasses, 'g'), '') + ' ' + activeClasses;
                } else {
                    button.className = button.className.replace(new RegExp(activeClasses, 'g'), '') + ' ' + inactiveClasses;
                }
            });
            hiddenInput.value = selectedTypes.join(',');
        }

        // Event listener untuk setiap tombol
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                const value = this.getAttribute('data-value');
                if (selectedTypes.includes(value)) {
                    // Hapus jika sudah ada (toggle off)
                    selectedTypes = selectedTypes.filter(type => type !== value);
                } else {
                    // Tambahkan jika belum ada (toggle on)
                    selectedTypes.push(value);
                }
                updateButtonStates();
            });
        });

        // Panggil fungsi inisialisasi
        updateButtonStates();
    });
    </script>
    @endpush
</x-app-layout>