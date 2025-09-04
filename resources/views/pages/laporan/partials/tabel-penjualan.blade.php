<div>
    <form method="GET" action="{{ route('laporan.index') }}" class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200">
            Laporan Penjualan Bulan:
        </h3>
        <div class="flex items-center gap-4">
            <input type="month" name="month" value="{{ $selectedMonth }}" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
            <button type="submit" class="inline-flex items-center px-4 py-2 bg-blue-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-600">Filter</button>
            <a href="{{ route('laporan.penjualan.export.pdf', ['month' => $selectedMonth]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
                Export PDF
            </a>
        </div>
    </form>

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
                {{-- PERBAIKAN: Mengganti $penjualans menjadi $penjualan --}}
                @forelse ($penjualan as $item)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal_penjualan)->format('d-m-Y') }}</td>
                    <td class="px-6 py-4">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
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