<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Dashboard Admin') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    {{-- statistik --}}
                    <div class="grid grid-cols-1 gap-6 mb-6 md:grid-cols-2 lg:grid-cols-4">
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow-sm dark:bg-gray-800 dark:border-gray-700">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ $totalSiswa }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Siswa</p>
                        </div>
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow-sm dark:bg-gray-800 dark:border-gray-700">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ $stokSampah }}</h5>
<p class="font-normal text-gray-700 dark:text-gray-400">Stok Sampah (kg)</p>
                        </div>
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow-sm dark:bg-gray-800 dark:border-gray-700">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($totalSetoran) }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Setoran</p>
                        </div>
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow-sm dark:bg-gray-800 dark:border-gray-700">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($totalPenjualan) }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Penjualan</p>
                        </div>
                        
                    </div>

                    {{-- chart --}}
                    <div class="w-full p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:p-6 dark:bg-gray-800 dark:border-gray-700">
                        <h5 class="mb-3 text-base font-semibold text-gray-900 md:text-xl dark:text-white">
                            Grafik Setoran dan Penjualan per Bulan
                        </h5>
                        <canvas id="myChart"></canvas>
                    </div>

                    {{-- Peringkat Siswa Dihapus Dari Sini --}}
                    
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
        labels: @json($labels),
        datasets: [{
            label: 'Setoran',
            data: @json($dataSetoran),
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }, {
            label: 'Penjualan',
            data: @json($dataPenjualan),
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
        }]
        },
        options: {
        scales: {
            y: {
            beginAtZero: true
            }
        }
        }
    });
    </script>
</x-app-layout>