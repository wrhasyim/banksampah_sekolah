<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Riwayat Insentif') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-semibold mb-6">Daftar Pembagian Insentif</h3>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal Penjualan</th>
                                    <th scope="col" class="px-6 py-3">Penerima (Kelas)</th>
                                    <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                    <th scope="col" class="px-6 py-3">Total Penjualan</th>
                                    <th scope="col" class="px-6 py-3">Jumlah Insentif</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifs as $insentif)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">{{ $insentif->penjualan->tanggal_penjualan->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $insentif->kelas->nama_kelas ?? 'Kelas Dihapus' }}</td>
                                    <td class="px-6 py-4">{{ $insentif->kelas->waliKelas->nama_lengkap ?? 'Belum Diatur' }}</td>
                                    <td class="px-6 py-4">Rp {{ number_format($insentif->penjualan->total_harga, 0, ',', '.') }}</td>
                                    <td class="px-6 py-4 font-medium text-green-600">Rp {{ number_format($insentif->jumlah_insentif, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="5" class="px-6 py-4 text-center">Belum ada data insentif.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>