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

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Siswa</h3>
                    <p class="mt-2 text-3xl font-bold">{{ $totalSiswa }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Saldo Siswa</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSaldo, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Setoran Siswa Hari Ini</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSetoranHariIni, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Penjualan</h3>
                    <p class="mt-2 text-3xl font-bold text-green-600">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Saldo Kas Saat Ini</h3>
                    <p class="mt-2 text-3xl font-bold text-indigo-600">Rp {{ number_format($saldoAkhirKas, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Pengeluaran</h3>
                    <p class="mt-2 text-3xl font-bold text-red-600">Rp {{ number_format($pengeluaranKas, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="mt-8 grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-2 space-y-6">
                    {{-- Bagian Grafik Baru --}}
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">Grafik Setoran Per Bulan</h3>
                        <canvas id="setoranChart"></canvas>
                    </div>

                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">腸 5 Transaksi Penjualan Terakhir</h3>
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
                                            <span class="font-semibold">{{ $item->detail_penjualan_sum_jumlah }}</span>
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
                    
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">嶋 5 Transaksi Kas Terakhir</h3>
                        <div class="relative overflow-x-auto">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                    <tr>
                                        <th class="px-4 py-2">Tanggal</th>
                                        <th class="px-4 py-2">Deskripsi</th>
                                        <th class="px-4 py-2 text-right">Nominal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($historiKas as $kas)
                                    <tr class="border-b">
                                        <td class="px-4 py-2">{{ \Carbon\Carbon::parse($kas->tanggal)->format('d M Y') }}</td>
                                        <td class="px-4 py-2 font-medium">{{ $kas->deskripsi }}</td>
                                        <td class="px-4 py-2 text-right font-semibold {{ $kas->tipe == 'pemasukan' ? 'text-green-600' : 'text-red-600' }}">
                                            {{ $kas->tipe == 'pemasukan' ? '+' : '-' }} Rp {{ number_format($kas->jumlah, 0, ',', '.') }}
                                        </td>
                                    </tr>
                                    @empty
                                    <tr><td colspan="3" class="px-4 py-2 text-center text-gray-500">Belum ada transaksi kas.</td></tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">醇 Peringkat Siswa Teraktif</h3>
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
                        <h3 class="text-lg font-medium text-gray-900 mb-4">醇 Peringkat Kelas Teraktif</h3>
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
        document.addEventListener('DOMContentLoaded', function () {
            fetch('{{ route('charts.setoran-per-bulan') }}')
                .then(response => response.json())
                .then(data => {
                    const labels = data.map(item => new Date(2000, item.bulan - 1).toLocaleString('id-ID', { month: 'long' }));
                    const values = data.map(item => item.total);

                    const ctx = document.getElementById('setoranChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Total Setoran',
                                data: values,
                                backgroundColor: 'rgba(59, 130, 246, 0.5)',
                                borderColor: 'rgba(59, 130, 246, 1)',
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
                });
        });
    </script>
    @endpush
</x-app-layout>