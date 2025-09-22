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
        // Skrip ini berlaku untuk form di dalam tabel-transaksi.blade.php
        const form = document.querySelector('#filter-transaksi-form');
        if (form) {
            const filterButtons = form.querySelectorAll('.btn-filter-jenis');
            const hiddenInput = form.querySelector('#transaction_type_input');

            const activeClasses = 'bg-blue-600 text-white hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 border-blue-600 dark:border-blue-500';
            const inactiveClasses = 'bg-white text-gray-900 hover:bg-gray-100 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600 border-gray-200 dark:border-gray-600';

            let selectedTypes = hiddenInput.value ? hiddenInput.value.split(',') : [];

            function updateButtonStates() {
                filterButtons.forEach(button => {
                    const value = button.getAttribute('data-value');
                    button.className = button.className.replace(new RegExp(activeClasses, 'g'), '').replace(new RegExp(inactiveClasses, 'g'), '');
                    if (selectedTypes.includes(value)) {
                        button.classList.add(...activeClasses.split(' '));
                    } else {
                        button.classList.add(...inactiveClasses.split(' '));
                    }
                });
                hiddenInput.value = selectedTypes.join(',');
            }

            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const value = this.getAttribute('data-value');
                    if (selectedTypes.includes(value)) {
                        selectedTypes = selectedTypes.filter(type => type !== value);
                    } else {
                        selectedTypes.push(value);
                    }
                    updateButtonStates();
                });
            });

            updateButtonStates();
        }
    });
    </script>
    @endpush
</x-app-layout>