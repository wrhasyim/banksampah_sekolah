<x-app-layout>
    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="p-6 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200 mb-6">Rekap Insentif Pengelola & Sekolah</h3>

                {{-- Form Filter Tanggal --}}
                <form action="{{ route('insentif.rekap') }}" method="GET" class="mb-6 p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                        <div>
                            <label for="start_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Mulai</label>
                            <input type="date" id="start_date" name="start_date" value="{{ $startDate }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600">
                        </div>
                        <div>
                            <label for="end_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Selesai</label>
                            <input type="date" id="end_date" name="end_date" value="{{ $endDate }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600">
                        </div>
                        <div>
                            <button type="submit" class="w-full px-4 py-2.5 text-white bg-blue-600 rounded-md hover:bg-blue-700">Terapkan Filter</button>
                        </div>
                    </div>
                </form>

                {{-- Tabel Insentif Pengelola --}}
                <div class="mb-8">
                    <h4 class="text-md font-semibold mb-4">Insentif Pengelola</h4>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Keterangan</th>
                                    <th scope="col" class="px-6 py-3">Jumlah</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifPengelola as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                                    <td class="px-6 py-4 font-medium">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="3" class="px-6 py-4 text-center">Tidak ada data insentif pengelola pada periode ini.</td>
                                </tr>
                                @endforelse
                            </tbody>
                            <tfoot class="font-semibold bg-gray-100 dark:bg-gray-700">
                                <tr>
                                    <td colspan="2" class="px-6 py-3 text-right">Total Insentif Pengelola:</td>
                                    <td class="px-6 py-3">Rp {{ number_format($totalPengelola, 0, ',', '.') }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                {{-- Tabel Insentif Sekolah --}}
                <div>
                    <h4 class="text-md font-semibold mb-4">Insentif Sekolah</h4>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Keterangan</th>
                                    <th scope="col" class="px-6 py-3">Jumlah</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifSekolah as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                                    <td class="px-6 py-4 font-medium">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="3" class="px-6 py-4 text-center">Tidak ada data insentif sekolah pada periode ini.</td>
                                </tr>
                                @endforelse
                            </tbody>
                             <tfoot class="font-semibold bg-gray-100 dark:bg-gray-700">
                                <tr>
                                    <td colspan="2" class="px-6 py-3 text-right">Total Insentif Sekolah:</td>
                                    <td class="px-6 py-3">Rp {{ number_format($totalSekolah, 0, ',', '.') }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>