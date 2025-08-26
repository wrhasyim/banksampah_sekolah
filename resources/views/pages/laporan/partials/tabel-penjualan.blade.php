<div class="relative overflow-x-auto shadow-md sm:rounded-lg max-h-80">
    <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
            <tr>
                <th class="px-6 py-3">Tanggal</th>
                <th class="px-6 py-3">Nota</th>
                <th class="px-6 py-3">Pengepul</th>
                <th class="px-6 py-3">Detail Sampah</th>
                <th class="px-6 py-3 text-right">Total (Rp)</th>
            </tr>
        </thead>
        <tbody class="divide-y">
            @forelse ($penjualans as $penjualan)
            <tr>
                <td class="px-6 py-4">{{ \Carbon\Carbon::parse($penjualan->tanggal_penjualan)->format('d M Y') }}</td>
                <td class="px-6 py-4">{{ $penjualan->kode_penjualan }}</td>
                <td class="px-6 py-4">{{ $penjualan->nama_pengepul }}</td>
                <td class="px-6 py-4">
                    <ul class="list-disc list-inside">
                        @foreach($penjualan->details as $detail)
                        <li>{{ $detail->jenisSampah->nama_sampah }}: {{ $detail->jumlah }} kg</li>
                        @endforeach
                    </ul>
                </td>
                <td class="px-6 py-4 text-right">{{ number_format($penjualan->total_harga, 0, ',', '.') }}</td>
            </tr>
            @empty
            <tr>
                <td colspan="5" class="px-6 py-4 text-center">Tidak ada data penjualan pada periode ini.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>
<div class="mt-4 font-semibold text-right">
    Total Penjualan: <span class="text-blue-600">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</span>
</div>