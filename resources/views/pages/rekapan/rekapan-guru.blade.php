<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Rekapan Setoran Guru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    
                    <div class="mb-6">
                        <form action="{{ route('rekapan.guru') }}" method="GET" class="flex items-end space-x-4">
                            <div>
                                <label for="start_date" class="block text-sm font-medium text-gray-700">Tanggal Mulai</label>
                                <input type="date" name="start_date" id="start_date" value="{{ $startDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                            </div>
                            <div>
                                <label for="end_date" class="block text-sm font-medium text-gray-700">Tanggal Selesai</label>
                                <input type="date" name="end_date" id="end_date" value="{{ $endDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                            </div>
                            <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700">
                                Filter
                            </button>
                            <a href="{{ route('rekapan.guru.exportPdf', ['start_date' => $startDate, 'end_date' => $endDate]) }}" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                Export PDF
                            </a>
                        </form>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">No</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nama Guru</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jumlah (Kg)</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Harga</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                @forelse ($setoranGuru as $setoran)
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $loop->iteration }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($setoran->created_at)->isoFormat('D MMMM Y') }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->pengguna->nama_lengkap ?? 'N/A' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jenisSampah->nama_sampah ?? 'N/A' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jumlah }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">Tidak ada data setoran untuk periode ini.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{ $setoranGuru->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>