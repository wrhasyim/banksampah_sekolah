<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard Admin') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Selamat Datang, {{ Auth::user()->nama_lengkap }}!</h3>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                        <div class="bg-blue-100 p-6 rounded-lg shadow">
                            <h4 class="text-sm font-medium text-blue-800">Total Siswa</h4>
                            <p class="text-3xl font-bold text-blue-900 mt-2">{{ $jumlahSiswa }}</p> </div>

                        <div class="bg-green-100 p-6 rounded-lg shadow">
                            <h4 class="text-sm font-medium text-green-800">Total Saldo Nasabah</h4>
                            <p class="text-3xl font-bold text-green-900 mt-2">Rp {{ number_format($totalSaldo, 0, ',', '.') }}</p>
                        </div>

                        <div class="bg-yellow-100 p-6 rounded-lg shadow">
                            <h4 class="text-sm font-medium text-yellow-800">Setoran Hari Ini</h4>
                            <p class="text-3xl font-bold text-yellow-900 mt-2">Rp {{ number_format($setoranHariIni, 0, ',', '.') }}</p>
                        </div>

                        <div class="bg-indigo-100 p-6 rounded-lg shadow">
                            <h4 class="text-sm font-medium text-indigo-800">Saldo Kas</h4>
                            <p class="text-3xl font-bold text-indigo-900 mt-2">Rp {{ number_format($saldoKas, 0, ',', '.') }}</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                        <div class="lg:col-span-2 bg-gray-50 p-6 rounded-lg shadow">
                            <h4 class="text-lg font-medium text-gray-800 mb-4">Grafik Setoran 7 Hari Terakhir</h4>
                            <canvas id="setoranChart"></canvas>
                        </div>

                        <div class="bg-gray-50 p-6 rounded-lg shadow">
                            <h4 class="text-lg font-medium text-gray-800 mb-4">Peringkat 5 Siswa Teratas</h4>
                             <canvas id="topSiswaChart"></canvas>
                        </div>
                    </div>
                    
                     <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
                        <div class="bg-gray-50 p-6 rounded-lg shadow">
                             <h4 class="text-lg font-medium text-gray-800 mb-4">5 Transaksi Kas Terbaru</h4>
                             <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-100">
                                        <tr>
                                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Deskripsi</th>
                                            <th class="px-4 py-2 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Jumlah</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        @forelse($recentTransactions as $transaksi)
                                            <tr>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500">{{ \Carbon\Carbon::parse($transaksi->tanggal)->format('d M Y') }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-900">{{ $transaksi->deskripsi }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-right font-medium {{ $transaksi->tipe == 'pemasukan' ? 'text-green-600' : 'text-red-600' }}">
                                                    {{ $transaksi->tipe == 'pemasukan' ? '+' : '-' }} Rp {{ number_format($transaksi->jumlah, 0, ',', '.') }}
                                                </td>
                                            </tr>
                                        @empty
                                            <tr>
                                                <td colspan="3" class="px-4 py-2 text-center text-sm text-gray-500">Tidak ada transaksi terbaru.</td>
                                            </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="bg-gray-50 p-6 rounded-lg shadow">
                             <h4 class="text-lg font-medium text-gray-800 mb-4">5 Penjualan Sampah Terbaru</h4>
                             <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                     <thead class="bg-gray-100">
                                        <tr>
                                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Pengepul</th>
                                            <th class="px-4 py-2 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total (kg)</th>
                                            <th class="px-4 py-2 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Nominal</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                         @forelse($recentSales as $penjualan)
                                            <tr>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500">{{ \Carbon\Carbon::parse($penjualan->created_at)->format('d M Y') }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-900">{{ $penjualan->nama_pengepul }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-right text-gray-500">{{ $penjualan->detail_penjualans_sum_jumlah ?? 0 }} kg</td>
                                                <td class="px-4 py-2 whitespace-nowrap text-sm text-right font-medium text-blue-600">
                                                    Rp {{ number_format($penjualan->total_harga, 0, ',', '.') }}
                                                </td>
                                            </tr>
                                        @empty
                                            <tr>
                                                <td colspan="4" class="px-4 py-2 text-center text-sm text-gray-500">Tidak ada penjualan terbaru.</td>
                                            </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    @push('scripts')
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Grafik Setoran
            const setoranCtx = document.getElementById('setoranChart').getContext('2d');
            const setoranData = @json($setoranChart);
            new Chart(setoranCtx, {
                type: 'line',
                data: {
                    labels: setoranData.map(item => new Date(item.tanggal).toLocaleDateString('id-ID', { day: 'numeric', month: 'short' })),
                    datasets: [{
                        label: 'Total Setoran',
                        data: setoranData.map(item => item.total),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        tension: 0.3
                    }]
                },
                options: { scales: { y: { beginAtZero: true } } }
            });

            // Grafik Top Siswa
            const topSiswaCtx = document.getElementById('topSiswaChart').getContext('2d');
            const topSiswaData = @json($topSiswa);
            new Chart(topSiswaCtx, {
                type: 'bar',
                data: {
                    labels: topSiswaData.labels,
                    datasets: [{
                        label: 'Total Setoran (Rp)',
                        data: topSiswaData.data,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: { 
                    indexAxis: 'y',
                    scales: { x: { beginAtZero: true } }
                }
            });
        </script>
    @endpush
</x-app-layout>