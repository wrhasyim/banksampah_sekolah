<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Rekapan Setoran Guru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">

                    <div class="mb-6 p-4 bg-gray-50 rounded-lg">
                        <h3 class="font-semibold text-lg text-gray-800 mb-3">Filter Berdasarkan Tanggal</h3>
                        <form action="{{ route('rekapan.indexGuru') }}" method="GET">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                                <div>
                                    <label for="start_date" class="block text-sm font-medium text-gray-700">Tanggal Mulai</label>
                                    <input type="date" name="start_date" id="start_date" value="{{ $startDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                                </div>
                                <div>
                                    <label for="end_date" class="block text-sm font-medium text-gray-700">Tanggal Selesai</label>
                                    <input type="date" name="end_date" id="end_date" value="{{ $endDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                                </div>
                                <div class="flex space-x-2">
                                    <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        <i class="fas fa-filter mr-2"></i> Terapkan Filter
                                    </button>
                                    <a href="{{ route('rekapan.indexGuru') }}" class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                        Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="mb-4 text-right">
                        <a href="{{ route('rekapan.exportGuruPdf', ['start_date' => $startDate, 'end_date' => $endDate]) }}"
                           class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700 active:bg-red-900 focus:outline-none focus:border-red-900 focus:ring ring-red-300 disabled:opacity-25 transition ease-in-out duration-150">
                            <i class="fas fa-file-pdf mr-2"></i> Export ke PDF
                        </a>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">No</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nama Guru</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Jumlah</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total Harga (Rp)</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                @forelse ($setoranGuru as $setoran)
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $loop->iteration + $setoranGuru->firstItem() - 1 }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jenisSampah->nama_sampah }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right">{{ number_format($setoran->jumlah, 0, ',', '.') }} {{ $setoran->jenisSampah->satuan }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right">{{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center text-gray-500">Tidak ada data setoran guru pada periode ini.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        {{ $setoranGuru->appends(request()->query())->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>