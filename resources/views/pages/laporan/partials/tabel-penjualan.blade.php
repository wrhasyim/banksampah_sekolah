<div>
    {{-- PERBAIKAN: Form filter dipindahkan ke tabel-transaksi, di sini hanya menampilkan data --}}
    <div class="flex items-center justify-between mb-4">
        <p class="text-sm text-gray-600 dark:text-gray-400">
            Menampilkan data penjualan untuk bulan: <strong>{{ \Carbon\Carbon::parse($selectedMonth)->isoFormat('MMMM YYYY') }}</strong>
        </p>
        {{-- PERBAIKAN: Tautan Export PDF membawa filter bulan yang aktif --}}
        <a href="{{ route('laporan.penjualan.export.pdf', ['month' => $selectedMonth]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700 focus:ring-4 focus:ring-red-300 dark:bg-red-500 dark:hover:bg-red-600">
            Export PDF
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