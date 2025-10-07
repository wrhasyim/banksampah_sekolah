<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Peringkat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            {{-- Form Filter --}}
            <div class="mb-6 bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-4">
                <form action="{{ route('leaderboard.index') }}" method="GET" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="filter" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Pilih Periode</label>
                        <select name="filter" id="filter" onchange="this.form.submit()" class="mt-1 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white">
                            <option value="semua_waktu" @if($filter == 'semua_waktu') selected @endif>Semua Waktu</option>
                            <option value="hari_ini" @if($filter == 'hari_ini') selected @endif>Hari Ini</option>
                            <option value="minggu_ini" @if($filter == 'minggu_ini') selected @endif>Minggu Ini</option>
                            <option value="bulan_ini" @if($filter == 'bulan_ini') selected @endif>Bulan Ini</option>
                            <option value="bulan_lalu" @if($filter == 'bulan_lalu') selected @endif>Bulan Lalu</option>
                        </select>
                    </div>
                    <div>
                        <label for="ranking_by" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Peringkat Berdasarkan</label>
                        <select name="ranking_by" id="ranking_by" onchange="this.form.submit()" class="mt-1 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white">
                            <option value="jumlah" @if($rankingBy == 'jumlah') selected @endif>Total Berat/Jumlah</option>
                            <option value="nominal" @if($rankingBy == 'nominal') selected @endif>Total Nominal (Rp)</option>
                        </select>
                    </div>
                </form>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {{-- Peringkat Siswa --}}
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-white">Peringkat Siswa Teratas</h3>
                    <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($topSiswa as $siswa)
                        <li x-data="{ open: false }" class="py-3 sm:py-4">
                            <div class="flex items-center space-x-4">
                                <div class="flex-shrink-0">
                                    <span class="text-xl font-bold text-gray-900 dark:text-white">{{ $loop->iteration }}</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-semibold text-gray-900 truncate dark:text-white">{{ $siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</p>
                                    <p class="text-xs text-gray-500 dark:text-gray-400">{{ $siswa->kelas->nama_kelas ?? '' }}</p>
                                </div>
                                <div class="text-right">
                                    <div class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                        @if($rankingBy === 'jumlah')
                                            {{ number_format($siswa->setoran_sum_jumlah, 0, ',', '.') }}
                                        @else
                                            Rp {{ number_format($siswa->setoran_sum_total_harga, 0, ',', '.') }}
                                        @endif
                                    </div>
                                    <button @click="open = !open" class="text-xs text-blue-500 hover:underline">
                                        <span x-show="!open">Lihat Rincian</span>
                                        <span x-show="open">Tutup Rincian</span>
                                    </button>
                                </div>
                            </div>
                            <div x-show="open" x-transition class="mt-3 pl-10 pr-4">
                                <ul class="list-disc list-inside text-sm text-gray-600 dark:text-gray-300 bg-gray-50 dark:bg-gray-700 p-3 rounded-md">
                                    @forelse($siswa->sampahDetails as $detail)
                                        <li>{{ $detail->nama_sampah }}: <strong class="font-semibold">{{ number_format($detail->total_jumlah, 2, ',', '.') }} {{ $detail->satuan }}</strong></li>
                                    @empty
                                        <li>Tidak ada rincian setoran.</li>
                                    @endforelse
                                </ul>
                            </div>
                        </li>
                        @empty
                        <li><p class="text-center text-gray-500 dark:text-gray-400 py-4">Tidak ada data setoran pada periode ini.</p></li>
                        @endforelse
                    </ul>
                </div>

                {{-- Peringkat Kelas --}}
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-semibold mb-4 text-gray-900 dark:text-white">Peringkat Kelas Teratas</h3>
                    <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                        @forelse($topKelas as $kelas)
                        <li x-data="{ open: false }" class="py-3 sm:py-4">
                             <div class="flex items-center space-x-4">
                                <div class="flex-shrink-0">
                                    <span class="text-xl font-bold text-gray-900 dark:text-white">{{ $loop->iteration }}</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-semibold text-gray-900 truncate dark:text-white">{{ $kelas->nama_kelas }}</p>
                                </div>
                                <div class="text-right">
                                    <div class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                        @if($rankingBy === 'jumlah')
                                            {{ number_format($kelas->total_agregat, 0, ',', '.') }}
                                        @else
                                            Rp {{ number_format($kelas->total_agregat, 0, ',', '.') }}
                                        @endif
                                    </div>
                                     <button @click="open = !open" class="text-xs text-blue-500 hover:underline">
                                        <span x-show="!open">Lihat Rincian</span>
                                        <span x-show="open">Tutup Rincian</span>
                                    </button>
                                </div>
                            </div>
                             <div x-show="open" x-transition class="mt-3 pl-10 pr-4">
                                <ul class="list-disc list-inside text-sm text-gray-600 dark:text-gray-300 bg-gray-50 dark:bg-gray-700 p-3 rounded-md">
                                    @forelse($kelas->sampahDetails as $detail)
                                        <li>{{ $detail->nama_sampah }}: <strong class="font-semibold">{{ number_format($detail->total_jumlah, 2, ',', '.') }} {{ $detail->satuan }}</strong></li>
                                    @empty
                                        <li>Tidak ada rincian setoran.</li>
                                    @endforelse
                                </ul>
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