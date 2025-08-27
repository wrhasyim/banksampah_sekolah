<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Papan Peringkat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <div class="flex items-center mb-6 space-x-2">
                        <a href="{{ route('leaderboard.index', ['filter' => 'all']) }}" class="px-4 py-2 text-sm font-medium {{ $filter == 'all' ? 'bg-blue-700 text-white' : 'bg-white text-gray-900' }} rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600">Semua</a>
                        <a href="{{ route('leaderboard.index', ['filter' => '7']) }}" class="px-4 py-2 text-sm font-medium {{ $filter == '7' ? 'bg-blue-700 text-white' : 'bg-white text-gray-900' }} rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600">7 Hari Terakhir</a>
                        <a href="{{ route('leaderboard.index', ['filter' => '30']) }}" class="px-4 py-2 text-sm font-medium {{ $filter == '30' ? 'bg-blue-700 text-white' : 'bg-white text-gray-900' }} rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600">30 Hari Terakhir</a>
                        <a href="{{ route('leaderboard.index', ['filter' => 'this_month']) }}" class="px-4 py-2 text-sm font-medium {{ $filter == 'this_month' ? 'bg-blue-700 text-white' : 'bg-white text-gray-900' }} rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600">Bulan Ini</a>
                    </div>

                    <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
                        <div class="p-4 bg-gray-100 border border-gray-200 rounded-lg shadow-sm dark:bg-gray-700 dark:border-gray-600">
                            <h5 class="mb-3 text-base font-semibold text-gray-900 md:text-xl dark:text-white">
                                Peringkat Siswa
                            </h5>
                            <ul class="my-4 space-y-3">
                                @forelse ($peringkatSiswa as $index => $siswa)
                                    <li>
                                        <a href="#" class="flex items-center p-3 text-base font-bold text-gray-900 bg-gray-50 rounded-lg hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white">
                                            <span class="mr-2">{{ $index + 1 }}.</span>
                                            <span class="flex-1 whitespace-nowrap">{{ $siswa->nama }} ({{ $siswa->kelas->nama }})</span>
                                            <span class="inline-flex items-center justify-center px-2 py-0.5 ml-3 text-xs font-medium text-gray-500 bg-gray-200 rounded dark:bg-gray-700 dark:text-gray-400">Rp {{ number_format($siswa->setoran_sum_total, 0, ',', '.') }}</span>
                                        </a>
                                    </li>
                                @empty
                                    <p class="text-gray-500 dark:text-gray-400">Tidak ada data setoran.</p>
                                @endforelse
                            </ul>
                        </div>

                        <div class="p-4 bg-gray-100 border border-gray-200 rounded-lg shadow-sm dark:bg-gray-700 dark:border-gray-600">
                            <h5 class="mb-3 text-base font-semibold text-gray-900 md:text-xl dark:text-white">
                                Peringkat Kelas
                            </h5>
                            <ul class="my-4 space-y-3">
                                @forelse ($peringkatKelas as $index => $kelas)
                                    <li>
                                        <a href="#" class="flex items-center p-3 text-base font-bold text-gray-900 bg-gray-50 rounded-lg hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white">
                                            <span class="mr-2">{{ $index + 1 }}.</span>
                                            <span class="flex-1 whitespace-nowrap">{{ $kelas->nama }}</span>
                                            <span class="inline-flex items-center justify-center px-2 py-0.5 ml-3 text-xs font-medium text-gray-500 bg-gray-200 rounded dark:bg-gray-700 dark:text-gray-400">Rp {{ number_format($kelas->siswa_setoran_sum_total, 0, ',', '.') }}</span>
                                        </a>
                                    </li>
                                @empty
                                    <p class="text-gray-500 dark:text-gray-400">Tidak ada data setoran.</p>
                                @endforelse
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>