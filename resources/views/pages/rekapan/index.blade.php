<x-app-layout>
    <x-slot name="header">
        <div class="flex justify-between items-center">
            <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
                {{ __('Rekapan Khusus Siswa') }}
            </h2>
            <a href="{{ route('rekapan.exportSiswaPdf') }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-500 focus:outline-none focus:border-red-700 focus:ring focus:ring-red-200 active:bg-red-600 disabled:opacity-25 transition">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                </svg>
                Export PDF
            </a>
        </div>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="mb-8 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-4 text-lg font-semibold">Rekapan Siswa Terlambat</h3>
                    <div class="overflow-x-auto">
                        <table class="min-w-full bg-white divide-y divide-gray-200 dark:bg-gray-800">
                            <thead class="bg-gray-50 dark:bg-gray-700">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Tanggal</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Total Harga</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                                @forelse ($setoranTerlambat as $setoran)
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($setoran->created_at)->format('d-m-Y H:i') }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jenisSampah->nama_sampah }}</td>
                                        <td class="px-6 py-4 text-right whitespace-nowrap">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center">Tidak ada data setoran terlambat.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{ $setoranTerlambat->links() }}
                    </div>
                </div>
            </div>

            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-4 text-lg font-semibold">Rekapan Setoran Tanpa Wali Kelas</h3>
                     <div class="overflow-x-auto">
                        <table class="min-w-full bg-white divide-y divide-gray-200 dark:bg-gray-800">
                            <thead class="bg-gray-50 dark:bg-gray-700">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Tanggal</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider dark:text-gray-300">Total Harga</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                                @forelse ($setoranTanpaWaliKelas as $setoran)
                                     <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($setoran->created_at)->format('d-m-Y H:i') }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jenisSampah->nama_sampah }}</td>
                                        <td class="px-6 py-4 text-right whitespace-nowrap">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                @empty
                                     <tr>
                                        <td colspan="5" class="px-6 py-4 text-center">Tidak ada data setoran tanpa wali kelas.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{ $setoranTanpaWaliKelas->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>