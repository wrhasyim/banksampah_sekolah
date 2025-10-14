<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Daftar Transaksi Setoran Terlambat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <div class="mb-6 p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                        <h3 class="font-semibold text-lg text-gray-800 dark:text-gray-200 mb-3">Filter Berdasarkan Tanggal</h3>
                        <form action="{{ route('rekapan.siswa-terlambat') }}" method="GET">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                                <div>
                                    <label for="start_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
                                    <input type="date" name="start_date" id="start_date" value="{{ $startDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-900 dark:border-gray-600">
                                </div>
                                <div>
                                    <label for="end_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
                                    <input type="date" name="end_date" id="end_date" value="{{ $endDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-900 dark:border-gray-600">
                                </div>
                                <div class="flex space-x-2">
                                    <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                        <i class="fas fa-filter mr-2"></i> Terapkan
                                    </button>
                                    <a href="{{ route('rekapan.siswa-terlambat') }}" class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 dark:bg-gray-600 dark:text-gray-300 dark:hover:bg-gray-500">
                                        Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="mb-4 text-right">
                        {{-- PERBAIKAN FINAL: Menggunakan nama route yang benar dari file web.php --}}
                        <a href="{{ route('rekapan.siswa-terlambat.exportPdf', ['start_date' => $startDate, 'end_date' => $endDate]) }}"
                           class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700">
                            <i class="fas fa-file-pdf mr-2"></i> Export ke PDF
                        </a>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">No</th>
                                    <th scope="col" class="px-6 py-3">Tanggal Setor</th>
                                    <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3">Kelas</th>
                                    <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-right">Jumlah</th>
                                    <th scope="col" class="px-6 py-3 text-right">Total Harga (Rp)</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($setoranTerlambat as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ $loop->iteration + $setoranTerlambat->firstItem() - 1 }}</td>
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->created_at)->isoFormat('D MMM Y, HH:mm') }}</td>
                                    <td class="px-6 py-4 font-medium text-gray-900 dark:text-white">{{ $item->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                                    <td class="px-6 py-4">{{ $item->siswa->kelas->nama_kelas ?? '-' }}</td>
                                    <td class="px-6 py-4">{{ $item->jenisSampah->nama_sampah ?? 'Sampah Dihapus' }}</td>
                                    <td class="px-6 py-4 text-right">{{ number_format($item->jumlah, 0, ',', '.') }} {{ $item->jenisSampah->satuan ?? '' }}</td>
                                    <td class="px-6 py-4 text-right">{{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="7" class="px-6 py-4 text-center">Tidak ada data setoran terlambat pada periode ini.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        {{ $setoranTerlambat->appends(request()->query())->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>