<div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th class="px-6 py-3">Tanggal</th>
                <th class="px-6 py-3">Nama Pengepul</th>
                <th class="px-6 py-3">Total Penjualan</th>
                <th class="px-6 py-3">Admin</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($results as $item)
            <tr class="bg-white border-b">
                <td class="px-6 py-4">{{ $item->created_at->format('d M Y') }}</td>
                <td class="px-6 py-4">{{ $item->nama_pengepul }}</td>
                <td class="px-6 py-4">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                <td class="px-6 py-4">{{ $item->admin->nama_lengkap }}</td>
            </tr>
            @empty
            <tr><td colspan="4" class="px-6 py-4 text-center">Tidak ada data untuk ditampilkan.</td></tr>
            @endforelse
        </tbody>
    </table>
</div>