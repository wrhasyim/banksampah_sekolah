<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Dashboard Admin') }}</h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="mb-6 flex space-x-4">
                <a href="{{ route('setoran.create') }}" class="px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-150">Catat Setoran</a>
                <a href="{{ route('penjualan.create') }}" class="px-6 py-3 bg-green-600 text-white font-semibold rounded-lg shadow-md hover:bg-green-700 transition duration-150">Catat Penjualan</a>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Siswa</h3>
                    <p class="mt-2 text-3xl font-bold">{{ $totalSiswa }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Saldo Siswa</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSaldo, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Setoran Hari Ini</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSetoranHariIni, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Penjualan</h3>
                    <p class="mt-2 text-3xl font-bold text-green-600">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="mt-8 grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-2 space-y-6">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-medium text-gray-900">📈 Tren Setoran</h3>
                            <form action="{{ route('dashboard') }}" method="GET" class="flex space-x-2 items-center text-sm">
                                <select name="tipe_grafik" onchange="this.form.submit()" class="border-gray-300 rounded-md shadow-sm text-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                                    <option value="nominal" {{ $tipeGrafik == 'nominal' ? 'selected' : '' }}>Berdasarkan Nominal (Rp)</option>
                                    <option value="jumlah" {{ $tipeGrafik == 'jumlah' ? 'selected' : '' }}>Berdasarkan Jumlah</option>
                                </select>
                                <select name="jangka_waktu" onchange="this.form.submit()" class="border-gray-300 rounded-md shadow-sm text-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                                    <option value="7" {{ $jangkaWaktu == '7' ? 'selected' : '' }}>7 Hari Terakhir</option>
                                    <option value="30" {{ $jangkaWaktu == '30' ? 'selected' : '' }}>30 Hari Terakhir</option>
                                    <option value="bulan_ini" {{ $jangkaWaktu == 'bulan_ini' ? 'selected' : '' }}>Bulan Ini</option>
                                </select>
                            </form>
                        </div>
                        <canvas id="setoranChart"></canvas>
                    </div>
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">📄 5 Transaksi Penjualan Terakhir</h3>
                        <div class="relative overflow-x-auto">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                    <tr>
                                        <th class="px-4 py-2">Tanggal</th>
                                        <th class="px-4 py-2">Pengepul</th>
                                        <th class="px-4 py-2 text-right">Total Jumlah</th>
                                        <th class="px-4 py-2 text-right">Nominal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($penjualanTerakhir as $item)
                                    <tr class="border-b">
                                        <td class="px-4 py-2">{{ $item->created_at->format('d M Y') }}</td>
                                        <td class="px-4 py-2 font-medium">{{ $item->nama_pengepul }}</td>
                                        <td class="px-4 py-2 text-right">
                                            {{-- Properti baru dari withSum (nama diganti) --}}
                                            <span class="font-semibold">{{ $item->detail_penjualan_sum_jumlah }}</span> 
                                            {{-- Teks satuan dihilangkan karena bisa campur (pcs/kg) --}}
                                        </td>
                                        <td class="px-4 py-2 text-right">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                    @empty
                                    <tr><td colspan="4" class="px-4 py-2 text-center text-gray-500">Belum ada data penjualan.</td></tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">🏆 Peringkat Siswa Teraktif</h3>
                        <ol class="list-decimal list-inside space-y-2">
                            @forelse ($peringkatSiswa as $siswa)
                                <li>
                                    <span class="font-semibold">{{ $siswa->pengguna->nama_lengkap }}</span>
                                    <span class="text-gray-600 text-sm float-right">{{ $siswa->total_jumlah }}</span>
                                </li>
                            @empty
                                <p class="text-gray-500">Belum ada data setoran.</p>
                            @endforelse
                        </ol>
                    </div>
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">🏆 Peringkat Kelas Teraktif</h3>
                        <ol class="list-decimal list-inside space-y-2">
                            @forelse ($peringkatKelas as $kelas)
                                <li>
                                    <span class="font-semibold">{{ $kelas->nama_kelas }}</span>
                                    <span class="text-gray-600 text-sm float-right">{{ $kelas->total_jumlah }}</span>
                                </li>
                            @empty
                                <p class="text-gray-500">Belum ada data setoran.</p>
                            @endforelse
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('setoranChart');
            if (ctx) {
                const chartData = @json($chartData);
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: chartData.labels,
                        datasets: [{
                            label: chartData.label,
                            data: chartData.data,
                            backgroundColor: 'rgba(59, 130, 246, 0.5)',
                            borderColor: 'rgba(59, 130, 246, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: { scales: { y: { beginAtZero: true } } }
                });
            }
        });
    </script>
    @endpush
</x-app-layout>