<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buku Kas Umum') }}
        </h2>
    </x-slot>

    {{-- PERUBAHAN UTAMA DIMULAI DARI SINI --}}
    <div class="py-12" x-data="{ openModal: false }">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-sm font-medium text-gray-500 truncate">Pemasukan ({{ \Carbon\Carbon::createFromFormat('Y-m', $selectedMonth)->isoFormat('MMMM YYYY') }})</h3>
                    <p class="mt-1 text-3xl font-semibold text-green-600">Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-sm font-medium text-gray-500 truncate">Pengeluaran ({{ \Carbon\Carbon::createFromFormat('Y-m', $selectedMonth)->isoFormat('MMMM YYYY') }})</h3>
                    <p class="mt-1 text-3xl font-semibold text-red-600">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-sm font-medium text-gray-500 truncate">Total Saldo Kas</h3>
                    <p class="mt-1 text-3xl font-semibold text-gray-900">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <h3 class="text-lg font-semibold mb-4 text-gray-800">Grafik Arus Kas (12 Bulan Terakhir)</h3>
                    <div>
                        <canvas id="bukuKasChart" height="100"></canvas>
                    </div>
                </div>
            </div>

            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <div class="flex flex-col md:flex-row justify-between items-center mb-4 space-y-2 md:space-y-0">
                        <form action="{{ route('buku-kas.index') }}" method="GET" class="flex items-center">
                            <x-input-label for="bulan" value="Pilih Bulan:" class="mr-2"/>
                            <input type="month" id="bulan" name="bulan" value="{{ $selectedMonth }}" class="border-gray-300 rounded-md shadow-sm text-sm">
                            <x-primary-button class="ml-2">Filter</x-primary-button>
                        </form>
                        <div class="flex items-center space-x-2">
                             <x-primary-button @click="openModal = true">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                                </svg>
                                Tambah Transaksi
                            </x-primary-button>
                            <form action="{{ route('buku-kas.export.pdf') }}" method="GET" class="inline-block">
                                <input type="hidden" name="bulan" value="{{ $selectedMonth }}">
                                <x-secondary-button type="submit">Export PDF</x-secondary-button>
                            </form>
                        </div>
                    </div>
                    @include('pages.buku-kas.partials.table')
                </div>
            </div>

            <div x-show="openModal" @keydown.escape.window="openModal = false" class="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true" style="display: none;">
                <div class="flex items-end justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
                    <div x-show="openModal" x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0" x-transition:enter-end="opacity-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0" class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" @click="openModal = false" aria-hidden="true"></div>
                    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
                    <div x-show="openModal" x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100" x-transition:leave-end="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
                                Tambah Transaksi Baru
                            </h3>
                            <div class="mt-4">
                                @include('pages.buku-kas.partials.create-form')
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    @push('scripts')
    {{-- Library Chart.js --}}
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Script untuk Grafik
            const ctx = document.getElementById('bukuKasChart').getContext('2d');
            fetch("{{ route('bukukas.chart.data') }}")
                .then(response => response.json())
                .then(data => {
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: 'Pemasukan',
                                data: data.pemasukan,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }, {
                                label: 'Pengeluaran',
                                data: data.pengeluaran,
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                borderColor: 'rgba(255, 99, 132, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return 'Rp ' + new Intl.NumberFormat('id-ID').format(value);
                                        }
                                    }
                                }
                            }
                        }
                    });
                })
                .catch(error => console.error('Error fetching chart data:', error));
        });
    </script>
    @endpush
</x-app-layout>