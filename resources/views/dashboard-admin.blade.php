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

                    {{-- --- PENYESUAIAN: Statistik Utama --- --}}
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($kas, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Kas</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ number_format($totalStokPcs, 2, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Stok Sampah (pcs)</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ number_format($totalStokKg, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Stok Sampah (Kg)</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Rp. {{ number_format($totalSetoran, 0, ',', '.') }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Setoran</p>
                        </div>
                        <div class="p-6 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm">
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ $totalSiswa }}</h5>
                            <p class="font-normal text-gray-700 dark:text-gray-400">Total Siswa</p>
                        </div>
                    </div>

                    {{-- Chart --}}
                    <div class="w-full p-4 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm sm:p-6 mb-6">
                        <h5 class="mb-3 text-base font-semibold text-gray-900 md:text-xl dark:text-white">
                            Grafik Setoran dan Penjualan per Bulan
                        </h5>
                        <canvas id="myChart"></canvas>
                    </div>

                </div>
            </div>
        </div>
        
        {{-- --- PENYESUAIAN: Grid Baru untuk Elemen Tambahan --- --}}
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 mt-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                {{-- Kolom 1: Stok Sampah per Jenis --}}
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-gray-100">♻️ Stok Sampah per Jenis</h3>
                    <ul class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($stokPerJenis as $jenis)
                        <li class="py-3 flex justify-between items-center text-gray-800 dark:text-gray-300">
                            <span>{{ $jenis->nama }}</span>
                            <span class="font-bold">{{ number_format($jenis->stok, 2, ',', '.') }} {{ $jenis->satuan }}</span>
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
                                <strong>{{ $setoran->siswa->pengguna->name }}</strong> menyetor sampah
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
                                <strong>{{ $penarikan->siswa->pengguna->name }}</strong> melakukan penarikan
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