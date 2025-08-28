<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Papan Peringkat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('leaderboard.index') }}" method="GET" class="mb-4">
                        <select name="filter" onchange="this.form.submit()" class="rounded-md shadow-sm border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                            <option value="minggu_ini" {{ $filter == 'minggu_ini' ? 'selected' : '' }}>Minggu Ini</option>
                            <option value="bulan_ini" {{ $filter == 'bulan_ini' ? 'selected' : '' }}>Bulan Ini</option>
                            <option value="tahun_ini" {{ $filter == 'tahun_ini' ? 'selected' : '' }}>Tahun Ini</option>
                            <option value="hari_ini" {{ $filter == 'hari_ini' ? 'selected' : '' }}>Hari Ini</option>
                        </select>
                    </form>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <h3 class="font-semibold text-lg mb-2">🏆 Top 10 Siswa Penyetor Terbanyak</h3>
                            <ul class="divide-y divide-gray-200">
                                @forelse($topSiswa as $index => $siswa)
                                    <li class="py-3 flex items-center justify-between">
                                        <div class="flex items-center">
                                            <span class="text-lg font-bold text-gray-500 mr-4">{{ $index + 1 }}</span>
                                            <div>
                                                <p class="font-medium text-gray-800">{{ $siswa->nama }}</p>
                                                <p class="text-sm text-gray-600">{{ $siswa->kelas->nama_kelas }}</p>
                                            </div>
                                        </div>
                                        <span class="font-semibold text-green-600">Rp {{ number_format($siswa->setoran_sum_total_harga, 0, ',', '.') }}</span>
                                    </li>
                                @empty
                                    <li class="py-3 text-gray-500">Belum ada data setoran.</li>
                                @endforelse
                            </ul>
                        </div>

                        <div>
                            <h3 class="font-semibold text-lg mb-2">🚀 Top 10 Kelas Penyetor Terbanyak</h3>
                            <ul class="divide-y divide-gray-200">
                                @forelse($topKelas as $index => $kelas)
                                    <li class="py-3 flex items-center justify-between">
                                        <div class="flex items-center">
                                            <span class="text-lg font-bold text-gray-500 mr-4">{{ $index + 1 }}</span>
                                            <p class="font-medium text-gray-800">{{ $kelas->nama_kelas }}</p>
                                        </div>
                                        <span class="font-semibold text-blue-600">Rp {{ number_format($kelas->siswa_setoran_sum_total_harga, 0, ',', '.') }}</span>
                                    </li>
                                @empty
                                    <li class="py-3 text-gray-500">Belum ada data setoran.</li>
                                @endforelse
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>