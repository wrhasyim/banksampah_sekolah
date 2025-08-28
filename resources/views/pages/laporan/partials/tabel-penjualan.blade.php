<div>
    <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200">
            Laporan Penjualan Bulan: {{ \Carbon\Carbon::parse($selectedMonth)->format('F Y') }}
        </h3>
        <a href="{{ route('laporan.penjualan.export.pdf', ['bulan' => $selectedMonth]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
            Export to PDF
        </a>
    </div>

    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">Tanggal Penjualan</th>
                    <th scope="col" class="px-6 py-3">Total Harga</th>
                    <th scope="col" class="px-6 py-3">Aksi</th>
                </tr>
            </thead>
            <tbody>
                {{-- PERBAIKAN: Mengganti $penjualan menjadi $penjualans --}}
                @forelse ($penjualans as $item)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal_penjualan)->format('d-m-Y') }}</td>
                    <td class="px-6 py-4">Rp {{ number_format($item->total_harga, 2, ',', '.') }}</td>
                    <td class="px-6 py-4">
                        <a href="{{ route('penjualan.show', $item->id) }}" class="text-blue-600 hover:underline">Detail</a>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="3" class="px-6 py-4 text-center">Tidak ada data penjualan untuk bulan ini.</td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>