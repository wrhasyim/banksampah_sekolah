<x-app-layout>
    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="p-6 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200 mb-6">Rekapitulasi Insentif Gabungan</h3>

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
                        <div class="flex space-x-2">
                            <button type="submit" class="w-full px-4 py-2.5 text-white bg-blue-600 rounded-md hover:bg-blue-700">Terapkan Filter</button>
                            <a href="{{ route('insentif.rekap') }}" class="w-full text-center px-4 py-2.5 text-gray-800 bg-gray-200 rounded-md hover:bg-gray-300">Reset</a>
                        </div>
                    </div>
                </form>

                <div class="mb-6 text-right">
                    <a href="{{ route('insentif.exportPdf', ['start_date' => $startDate, 'end_date' => $endDate]) }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700">
                        <i class="fas fa-file-pdf mr-2"></i> Export ke PDF
                    </a>
                </div>

                {{-- Tabel Insentif Wali Kelas --}}
                <div class="mb-8">
                    <h4 class="text-md font-semibold mb-4 dark:text-gray-200">Insentif Wali Kelas</h4>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Nama Wali Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-right">Total Insentif (Rp)</th>
                                    <th scope="col" class="px-6 py-3 text-right">Sudah Dibayar (Rp)</th>
                                    <th scope="col" class="px-6 py-3 text-right">Belum Dibayar (Rp)</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($rekapWaliKelas as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4 font-medium text-gray-900 dark:text-white">{{ $item['nama_wali_kelas'] }}</td>
                                    <td class="px-6 py-4 text-right">Rp {{ number_format($item['total_insentif'], 0, ',', '.') }}</td>
                                    <td class="px-6 py-4 text-right text-green-500">Rp {{ number_format($item['sudah_dibayar'], 0, ',', '.') }}</td>
                                    <td class="px-6 py-4 text-right text-red-500">Rp {{ number_format($item['belum_dibayar'], 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr><td colspan="4" class="px-6 py-4 text-center">Tidak ada data insentif wali kelas pada periode ini.</td></tr>
                                @endforelse
                            </tbody>
                            <tfoot class="font-semibold bg-gray-100 dark:bg-gray-700 dark:text-gray-300">
                                <tr>
                                    <td class="px-6 py-3 text-right" colspan="3">Total Insentif Wali Kelas (Periode ini):</td>
                                    <td class="px-6 py-3 text-right">Rp {{ number_format($totalWaliKelas, 0, ',', '.') }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                {{-- Tabel Insentif Pengelola --}}
                <div class="mb-8">
                    <h4 class="text-md font-semibold mb-4 dark:text-gray-200">Insentif Pengelola</h4>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Keterangan</th>
                                    <th scope="col" class="px-6 py-3 text-right">Jumlah</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifPengelola as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                                    <td class="px-6 py-4 font-medium text-right">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr><td colspan="3" class="px-6 py-4 text-center">Tidak ada data insentif pengelola pada periode ini.</td></tr>
                                @endforelse
                            </tbody>
                            <tfoot class="font-semibold bg-gray-100 dark:bg-gray-700 dark:text-gray-300">
                                <tr>
                                    <td colspan="2" class="px-6 py-3 text-right">Total Insentif Pengelola (Periode ini):</td>
                                    <td class="px-6 py-3 text-right">Rp {{ number_format($totalPengelola, 0, ',', '.') }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="mt-4">{{ $insentifPengelola->withQueryString()->links() }}</div>
                </div>

                {{-- Tabel Insentif Sekolah --}}
                <div>
                    <h4 class="text-md font-semibold mb-4 dark:text-gray-200">Insentif Sekolah</h4>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                             <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Keterangan</th>
                                    <th scope="col" class="px-6 py-3 text-right">Jumlah</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifSekolah as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                                    <td class="px-6 py-4 font-medium text-right">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr><td colspan="3" class="px-6 py-4 text-center">Tidak ada data insentif sekolah pada periode ini.</td></tr>
                                @endforelse
                            </tbody>
                             <tfoot class="font-semibold bg-gray-100 dark:bg-gray-700 dark:text-gray-300">
                                <tr>
                                    <td colspan="2" class="px-6 py-3 text-right">Total Insentif Sekolah (Periode ini):</td>
                                    <td class="px-6 py-3 text-right">Rp {{ number_format($totalSekolah, 0, ',', '.') }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="mt-4">{{ $insentifSekolah->withQueryString()->links() }}</div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>