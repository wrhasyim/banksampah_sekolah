<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Dashboard Admin') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">

            <div class="bg-white dark:bg-gray-800 shadow-sm sm:rounded-lg p-4">
                <div class="flex items-center space-x-4">
                    <h3 class="text-lg font-semibold text-gray-700 dark:text-gray-300 flex-shrink-0">Aksi Cepat:</h3>
                    <a href="{{ route('setoran.create.massal') }}" class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-500 focus:outline-none focus:border-blue-700 focus:ring focus:ring-blue-200 active:bg-blue-600 disabled:opacity-25 transition">Setoran Massal</a>
                    <a href="{{ route('penjualan.create') }}" class="inline-flex items-center px-4 py-2 bg-green-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-green-500 focus:outline-none focus:border-green-700 focus:ring focus:ring-green-200 active:bg-green-600 disabled:opacity-25 transition">Lakukan Penjualan</a>
                    <a href="{{ route('buku-kas.index') }}" class="inline-flex items-center px-4 py-2 bg-yellow-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-yellow-400 focus:outline-none focus:border-yellow-600 focus:ring focus:ring-yellow-200 active:bg-yellow-500 disabled:opacity-25 transition">Catat Pengeluaran</a>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm"><h5 class="text-sm font-medium text-gray-500 dark:text-gray-400">Kas di Tangan</h5><p class="mt-1 text-3xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($kas, 0, ',', '.') }}</p></div>
                <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm"><h5 class="text-sm font-medium text-gray-500 dark:text-gray-400">Potensi Laba dari Stok</h5><p class="mt-1 text-3xl font-bold tracking-tight text-green-600 dark:text-green-400">Rp. {{ number_format($nilaiStokJual - $modalStokBeli, 0, ',', '.') }}</p><p class="text-xs text-gray-500 mt-1">Nilai Jual: Rp {{ number_format($nilaiStokJual, 0, ',', '.') }}</p></div>
                <div class="p-6 bg-red-50 dark:bg-red-900/50 border border-red-200 dark:border-red-700 rounded-lg shadow-sm"><h5 class="text-sm font-medium text-red-700 dark:text-red-300">Insentif Belum Dibayar</h5><p class="mt-1 text-3xl font-bold tracking-tight text-red-800 dark:text-red-200">Rp. {{ number_format($totalInsentifBelumDibayar, 0, ',', '.') }}</p></div>
                <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm"><h5 class="text-sm font-medium text-gray-500 dark:text-gray-400">Laba Bersih Bulan Ini</h5><p class="mt-1 text-3xl font-bold tracking-tight text-blue-800 dark:text-blue-300">Rp. {{ number_format($labaBersihBulanIni, 0, ',', '.') }}</p></div>
            </div>
            
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-2 space-y-6">
                    <div class="w-full p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm sm:p-6">
                         <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-4">
                             <h5 id="chart-title" class="mb-3 sm:mb-0 text-base font-semibold text-gray-900 md:text-xl dark:text-white">Grafik Transaksi</h5>
                             <div class="flex items-center space-x-2">
                                 <button data-type="transaksi" class="chart-type-btn px-3 py-1 text-sm font-medium text-white bg-blue-600 rounded-md">Analisis Transaksi</button>
                                 <button data-type="sampah" class="chart-type-btn px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600">Analisis Stok Sampah</button>
                             </div>
                         </div>
                         <div class="h-[28rem]">
                              <canvas id="myChart"></canvas>
                         </div>
                    </div>
                     <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-gray-100">🕒 Aktivitas Terkini</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <h4 class="font-semibold text-gray-800 dark:text-gray-200">Setoran Terakhir</h4>
                                <ul class="text-sm text-gray-600 dark:text-gray-400 mt-2 space-y-2">
                                     @forelse($aktivitasTerakhir['setoran'] as $setoran)
                                     <li><strong>{{ Str::limit($setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus', 25) }}</strong> +Rp{{ number_format($setoran->total_harga, 0, ',', '.') }}</li>
                                     @empty
                                     <li>Tidak ada setoran baru.</li>
                                     @endforelse
                                </ul>
                            </div>
                            <div>
                                <h4 class="font-semibold text-gray-800 dark:text-gray-200">Penarikan Terakhir</h4>
                                <ul class="text-sm text-gray-600 dark:text-gray-400 mt-2 space-y-2">
                                    @forelse($aktivitasTerakhir['penarikan'] as $penarikan)
                                    <li><strong>{{ Str::limit($penarikan->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus', 25) }}</strong> -Rp{{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}</li>
                                    @empty
                                    <li>Tidak ada penarikan baru.</li>
                                    @endforelse
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-1 space-y-6">
                    <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-4">🔔 Tugas & Perhatian</h3>
                        <ul class="space-y-3">
                            @if($totalInsentifBelumDibayar > 0)
                                <li class="flex items-start"><span class="text-red-500 mr-2 mt-1">⚠️</span><div><p class="font-semibold text-red-700 dark:text-red-400">Bayar Insentif</p><p class="text-sm text-gray-600 dark:text-gray-400">Ada Rp {{ number_format($totalInsentifBelumDibayar, 0, ',', '.') }} insentif perlu dibayar. <a href="{{ route('insentif.pembayaran') }}" class="text-blue-600 hover:underline">Proses sekarang</a>.</p></div></li>
                            @endif
                            @php $sampahSiapJual = $stokPerJenis->firstWhere('stok', '>', 50); @endphp
                            @if($sampahSiapJual)
                                 <li class="flex items-start"><span class="text-green-500 mr-2 mt-1">💡</span><div><p class="font-semibold text-green-700 dark:text-green-400">Stok Siap Jual</p><p class="text-sm text-gray-600 dark:text-gray-400">Stok {{ $sampahSiapJual->nama_sampah }} sudah banyak. <a href="{{ route('penjualan.create') }}" class="text-blue-600 hover:underline">Lakukan penjualan</a>.</p></div></li>
                            @endif
                            @if($totalInsentifBelumDibayar == 0 && !$sampahSiapJual)
                                <li class="text-sm text-gray-500 dark:text-gray-400">Tidak ada tugas mendesak.</li>
                            @endif
                        </ul>
                    </div>
                    <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-4">♻️ Komposisi Stok</h3>
                        <canvas id="stockPieChart" class="max-h-64 mx-auto"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </div>

    @push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            Chart.register(ChartDataLabels);

            const ctx = document.getElementById('myChart').getContext('2d');
            let myChart;
            const chartTypeButtons = document.querySelectorAll('.chart-type-btn');
            const chartTitle = document.getElementById('chart-title');
            const defaultButtonClasses = 'px-3 py-1 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-600';
            const activeButtonClasses = 'px-3 py-1 text-sm font-medium text-white bg-blue-600 rounded-md';
            let currentType = 'transaksi';

            const renderChart = async () => {
                if (myChart) { myChart.destroy(); }
                
                let chartConfig;
                if (currentType === 'transaksi') {
                    chartTitle.innerText = 'Grafik Analisis Transaksi';
                    const response = await axios.get(`{{ route('dashboard.chart.data') }}`);
                    const data = response.data;
                    const createGradient = (ctx, color1, color2) => {
                        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
                        gradient.addColorStop(0, color1);
                        gradient.addColorStop(1, color2);
                        return gradient;
                    };
                    chartConfig = {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: 'Setoran', data: data.dataSetoran, backgroundColor: createGradient(ctx, 'rgba(59, 130, 246, 0.6)', 'rgba(59, 130, 246, 0.1)'),
                                borderColor: 'rgba(59, 130, 246, 1)', borderWidth: 2, tension: 0.4, fill: true, pointBackgroundColor: 'rgba(59, 130, 246, 1)', pointRadius: 4, pointHoverRadius: 6
                            }, {
                                label: 'Penjualan', data: data.dataPenjualan, backgroundColor: createGradient(ctx, 'rgba(34, 197, 94, 0.6)', 'rgba(34, 197, 94, 0.1)'),
                                borderColor: 'rgba(34, 197, 94, 1)', borderWidth: 2, tension: 0.4, fill: true, pointBackgroundColor: 'rgba(34, 197, 94, 1)', pointRadius: 4, pointHoverRadius: 6
                            }]
                        },
                        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, ticks: { callback: (value) => 'Rp ' + new Intl.NumberFormat('id-ID').format(value) } } }, plugins: { tooltip: { callbacks: { label: (ctx) => `${ctx.dataset.label}: Rp ${new Intl.NumberFormat('id-ID').format(ctx.parsed.y)}` } } } }
                    };
                } else if (currentType === 'sampah') {
                    chartTitle.innerText = 'Grafik Analisis Profitabilitas Stok';
                    const response = await axios.get(`{{ route('dashboard.chart.bubble') }}`);
                    const data = response.data;
                    const colors = ['#4ade80', '#60a5fa', '#facc15', '#fb923c', '#a78bfa', '#f87171', '#2dd4bf'];
                    chartConfig = {
                        type: 'bubble',
                        data: {
                            datasets: [{
                                label: 'Stok Sampah',
                                data: data.map(item => ({
                                    x: item.x, y: item.y, r: item.r,
                                    label: item.label, stok: item.stok, satuan: item.satuan
                                })),
                                backgroundColor: data.map((item, index) => colors[index % colors.length] + 'BF'),
                                borderColor: data.map((item, index) => colors[index % colors.length]),
                            }]
                        },
                        options: {
                            responsive: true, maintainAspectRatio: false,
                            scales: {
                                y: { title: { display: true, text: 'Harga Jual (Rp)' }, ticks: { callback: (value) => new Intl.NumberFormat('id-ID').format(value) } },
                                x: { title: { display: true, text: 'Harga Beli (Rp)' }, ticks: { callback: (value) => new Intl.NumberFormat('id-ID').format(value) } }
                            },
                            plugins: {
                                legend: { display: false },
                                tooltip: {
                                    callbacks: {
                                        label: (ctx) => {
                                            const item = ctx.raw;
                                            return [
                                                `${item.label}`,
                                                `Stok: ${new Intl.NumberFormat('id-ID').format(item.stok)} ${item.satuan}`,
                                                `Harga Beli: Rp ${new Intl.NumberFormat('id-ID').format(item.x)}`,
                                                `Harga Jual: Rp ${new Intl.NumberFormat('id-ID').format(item.y)}`
                                            ];
                                        }
                                    }
                                }
                            }
                        }
                    };
                }
                myChart = new Chart(ctx, chartConfig);
            };

            chartTypeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    chartTypeButtons.forEach(btn => btn.className = defaultButtonClasses);
                    this.className = activeButtonClasses;
                    currentType = this.getAttribute('data-type');
                    renderChart();
                });
            });
            
            renderChart();

            // Script untuk Pie Chart Komposisi Stok
            const ctxPie = document.getElementById('stockPieChart').getContext('2d');
            const stokData = @json($stokPerJenis->where('stok', '>', 0)->values());
            new Chart(ctxPie, {
                type: 'doughnut',
                data: {
                    labels: stokData.map(item => `${item.nama_sampah} (${item.satuan})`),
                    datasets: [{
                        label: 'Stok Sampah',
                        data: stokData.map(item => item.stok),
                        backgroundColor: [ '#4ade80', '#60a5fa', '#facc15', '#fb923c', '#a78bfa', '#f87171', '#2dd4bf' ],
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: { 
                        legend: { display: false },
                        datalabels: {
                            formatter: (value, ctx) => {
                                let label = ctx.chart.data.labels[ctx.dataIndex];
                                let name = label.substring(0, label.lastIndexOf(' ('));
                                let unit = label.substring(label.lastIndexOf('(') + 1, label.lastIndexOf(')'));
                                let formattedValue = new Intl.NumberFormat('id-ID').format(value);
                                return `${name}\n${formattedValue} ${unit}`;
                            },
                            color: '#fff', textAlign: 'center', font: { weight: 'bold', size: 11 },
                            backgroundColor: 'rgba(0, 0, 0, 0.6)', borderRadius: 4, padding: 4
                        }
                    }
                }
            });
        });
    </script>
    @endpush
</x-app-layout>