<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Dashboard Admin') }}
        </h2>
    </x-slot>

    <div class="py-12">

        {{-- Notifikasi Penting --}}
        @if(!empty($notifikasi))
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 mb-6">
                @foreach($notifikasi as $pesan)
                    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 rounded-lg shadow-md" role="alert">
                        <p class="font-bold">🔔 Perhatian</p>
                        <p>{{ $pesan }}</p>
                    </div>
                @endforeach
            </div>
        @endif

        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    {{-- Statistik Utama --}}
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                        <div class="p-6 bg-green-50 dark:bg-green-900/50 border border-green-200 dark:border-green-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-green-800 dark:text-green-300">Rp. {{ number_format($pemasukanBulanIni, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Pemasukan Bulan Ini</p>
                        </div>
                        <div class="p-6 bg-red-50 dark:bg-red-900/50 border border-red-200 dark:border-red-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-red-800 dark:text-red-300">Rp. {{ number_format($pengeluaranBulanIni, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Pengeluaran Bulan Ini</p>
                        </div>
                        <div class="p-6 bg-blue-50 dark:bg-blue-900/50 border border-blue-200 dark:border-blue-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-blue-800 dark:text-blue-300">Rp. {{ number_format($labaBersihBulanIni, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Laba Bersih Bulan Ini</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($kas, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Kas</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ number_format($totalStokPcs, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Stok Sampah (pcs)</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ number_format($totalStokKg, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Stok Sampah (Kg)</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($totalSetoran, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Setoran Siswa</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ $totalSiswa }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Siswa</p>
                        </div>
                    </div>

                    {{-- Chart Multifungsi --}}
                    <div class="w-full p-4 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm sm:p-6 mb-6">
                        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-4">
                            <h5 id="chart-title" class="mb-3 sm:mb-0 text-base font-semibold text-gray-900 md:text-xl dark:text-white">
                                Grafik Transaksi
                            </h5>
                            <div class="flex items-center space-x-2">
                                <button data-type="transaksi" class="chart-type-btn px-3 py-1 text-sm font-medium text-white bg-blue-600 rounded-md">Transaksi</button>
                                <button data-type="sampah" class="chart-type-btn px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600">Jenis Sampah</button>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2 mb-4">
                            <button data-period="today" class="chart-filter-btn px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600">Hari Ini</button>
                            <button data-period="7d" class="chart-filter-btn px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600">7 Hari</button>
                            <button data-period="30d" class="chart-filter-btn px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600">30 Hari</button>
                            <button data-period="monthly" class="chart-filter-btn px-3 py-1 text-sm font-medium text-white bg-blue-600 rounded-md">Bulan Ini</button>
                        </div>
                        <div class="h-96">
                             <canvas id="myChart"></canvas>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 mt-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                {{-- Kolom 1: Stok Sampah per Jenis --}}
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-gray-100">♻️ Stok Sampah per Jenis</h3>
                    <ul class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($stokPerJenis as $jenis)
                        <li class="py-3 flex justify-between items-center text-gray-800 dark:text-gray-300">
                            <span>{{ $jenis->nama_sampah }}</span>
                            <span class="font-bold">{{ number_format($jenis->stok, 0, ',', '.') }} {{ $jenis->satuan }}</span>
                        </li>
                        @empty
                        <li class="py-3 text-gray-500 dark:text-gray-400">Belum ada data stok.</li>
                        @endforelse
                    </ul>
                </div>

                {{-- Kolom 2: Aktivitas Terkini --}}
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-gray-100">🔔 Aktivitas Terkini</h3>
                    <div>
                        <h4 class="font-semibold text-sm mt-4 text-gray-800 dark:text-gray-200">Setoran Terakhir</h4>
                        <ul class="text-sm text-gray-600 dark:text-gray-400 mt-2 space-y-2">
                            @forelse($aktivitasTerakhir['setoran'] as $setoran)
                            <li>
                                <strong>{{ $setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</strong> menyetor sampah
                                senilai Rp{{ number_format($setoran->total_harga, 0, ',', '.') }}
                            </li>
                            @empty
                            <li>Tidak ada setoran baru.</li>
                            @endforelse
                        </ul>
                        
                        <h4 class="font-semibold text-sm mt-6 text-gray-800 dark:text-gray-200">Penarikan Terakhir</h4>
                        <ul class="text-sm text-gray-600 dark:text-gray-400 mt-2 space-y-2">
                            @forelse($aktivitasTerakhir['penarikan'] as $penarikan)
                            <li>
                                @if($penarikan->siswa)
                                    <strong>{{ $penarikan->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</strong> melakukan penarikan
                                @elseif($penarikan->kelas)
                                    <strong>Kelas {{ $penarikan->kelas->nama_kelas ?? 'Kelas Dihapus' }}</strong> melakukan penarikan kolektif
                                @endif
                                senilai Rp{{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}
                            </li>
                            @empty
                            <li>Tidak ada penarikan baru.</li>
                            @endforelse
                        </ul>
                    </div>
                </div>

            </div>
        </div>

    </div>

      @push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ctx = document.getElementById('myChart');
            let myChart;
            
            const chartTypeButtons = document.querySelectorAll('.chart-type-btn');
            const filterButtons = document.querySelectorAll('.chart-filter-btn');
            const chartTitle = document.getElementById('chart-title');

            const defaultButtonClasses = 'px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600';
            const activeButtonClasses = 'px-3 py-1 text-sm font-medium text-white bg-blue-600 rounded-md';

            let currentPeriod = 'monthly';
            let currentType = 'transaksi';

            const renderChart = (data) => {
                if (myChart) {
                    myChart.destroy();
                }

                let chartConfig;
                if (currentType === 'transaksi') {
                    chartTitle.innerText = 'Grafik Transaksi';
                    chartConfig = {
                        type: (currentPeriod === 'monthly') ? 'bar' : 'line',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: 'Setoran',
                                data: data.dataSetoran,
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1,
                                tension: 0.1
                            }, {
                                label: 'Penjualan',
                                data: data.dataPenjualan,
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                borderColor: 'rgba(255, 99, 132, 1)',
                                borderWidth: 1,
                                tension: 0.1
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
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
                    };
                } else { // **INI BAGIAN PERBAIKANNYA**
                    chartTitle.innerText = 'Grafik Jumlah Sampah Terkumpul';
                    chartConfig = {
                        type: 'bar',
                        data: {
                            labels: data.labels, // Label dari controller
                            datasets: [{
                                label: 'Jumlah Sampah',
                                data: data.data, // Data dari controller
                                backgroundColor: 'rgba(75, 192, 192, 0.5)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    title: {
                                        display: true,
                                        text: 'Jumlah (Kg/Pcs)'
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false // Sembunyikan legenda karena sudah jelas dari judul
                                }
                            }
                        }
                    };
                }
                
                myChart = new Chart(ctx, chartConfig);
            };

            const fetchChartData = async () => {
                try {
                    // Pastikan URL-nya benar menunjuk ke rute yang sudah kita perbaiki
                    const response = await axios.get(`{{ route('dashboard.chart') }}?type=${currentType}&period=${currentPeriod}`);
                    renderChart(response.data);
                } catch (error) {
                    console.error('Gagal memuat data chart:', error);
                }
            };

            chartTypeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    chartTypeButtons.forEach(btn => btn.className = defaultButtonClasses);
                    this.className = activeButtonClasses;
                    currentType = this.getAttribute('data-type');
                    fetchChartData();
                });
            });

            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    filterButtons.forEach(btn => btn.className = defaultButtonClasses);
                    this.className = activeButtonClasses;
                    currentPeriod = this.getAttribute('data-period');
                    fetchChartData();
                });
            });

            // Panggil data awal
            fetchChartData();
        });
    </script>
    @endpush
</x-app-layout>