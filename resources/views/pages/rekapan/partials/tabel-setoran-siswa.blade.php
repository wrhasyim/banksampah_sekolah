<div class="bg-gray-50 p-4 rounded-lg border">
    <h3 class="font-semibold text-lg mb-3">Rekap Setoran Siswa</h3>
    @if($setoranSiswa->isEmpty())
        <p class="text-gray-500">Belum ada data setoran siswa untuk periode ini.</p>
    @else
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-100">
                <tr>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jenis Sampah</th>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jumlah (Pcs)</th>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Total Harga</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                @foreach($setoranSiswa as $item)
                <tr>
                    <td class="px-4 py-2 whitespace-nowrap">{{ $item->jenis_sampah }}</td>
                    <td class="px-4 py-2 whitespace-nowrap">{{ number_format($item->total_jumlah, 0, ',', '.') }}</td>
                    <td class="px-4 py-2 whitespace-nowrap">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                </tr>
                @endforeach
            </tbody>
            <tfoot class="bg-gray-100 font-bold">
                <tr>
                    <td class="px-4 py-2 text-right" colspan="2">Total Pemasukan Siswa</td>
                    <td class="px-4 py-2">Rp {{ number_format($totalSetoranSiswa, 0, ',', '.') }}</td>
                </tr>
            </tfoot>
        </table>
    @endif
</div>