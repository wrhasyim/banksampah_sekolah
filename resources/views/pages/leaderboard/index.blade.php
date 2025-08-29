<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Peringkat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            <div class="mb-6">
                <form action="{{ route('leaderboard.index') }}" method="GET">
                    <select name="filter" onchange="this.form.submit()" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full md:w-1/4 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white">
                        <option value="minggu_ini" @if($filter == 'minggu_ini') selected @endif>Minggu Ini</option>
                        <option value="hari_ini" @if($filter == 'hari_ini') selected @endif>Hari Ini</option>
                        <option value="bulan_ini" @if($filter == 'bulan_ini') selected @endif>Bulan Ini</option>
                        <option value="tahun_ini" @if($filter == 'tahun_ini') selected @endif>Tahun Ini</option>
                    </select>
                </form>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-2 bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-white">Peringkat Siswa Teratas</h3>
                    <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($topSiswa as $siswa)
                        <li class="py-3 sm:py-4">
                            <div class="flex items-center space-x-4">
                                <div class="flex-shrink-0">
                                    <span class="text-xl font-bold text-gray-900 dark:text-white">{{ $loop->iteration }}</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-semibold text-gray-900 truncate dark:text-white">
                                        {{-- PERBAIKAN: Ganti ke 'name' dan tambah fallback --}}
                                        {{ $siswa->pengguna->name ?? 'Siswa Telah Dihapus' }}
                                    </p>
                                    <p class="text-xs text-gray-500 truncate dark:text-gray-400">
                                        {{ $siswa->kelas->nama_kelas ?? 'Tanpa Kelas' }}
                                    </p>
                                </div>
                                <div class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                    Rp {{ number_format($siswa->setoran_sum_total_harga, 0, ',', '.') }}
                                </div>
                            </div>
                        </li>
                        @empty
                        <li><p class="text-center text-gray-500 dark:text-gray-400 py-4">Tidak ada data setoran pada periode ini.</p></li>
                        @endforelse
                    </ul>
                </div>

                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-white">Peringkat Kelas Teratas</h3>
                    <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($topKelas as $kelas)
                        <li class="py-3 sm:py-4">
                            <div class="flex items-center space-x-4">
                                <div class="flex-shrink-0">
                                    <span class="text-xl font-bold text-gray-900 dark:text-white">{{ $loop->iteration }}</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-semibold text-gray-900 truncate dark:text-white">{{ $kelas->nama_kelas }}</p>
                                </div>
                                <div class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                    Rp {{ number_format($kelas->setoran_sum_total_harga, 0, ',', '.') }}
                                </div>
                            </div>
                        </li>
                        @empty
                        <li><p class="text-center text-gray-500 dark:text-gray-400 py-4">Tidak ada data setoran pada periode ini.</p></li>
                        @endforelse
                    </ul>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>