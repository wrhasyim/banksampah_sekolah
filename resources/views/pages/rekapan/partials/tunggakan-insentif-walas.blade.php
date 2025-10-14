<div class="bg-yellow-50 p-4 rounded-lg border border-yellow-200">
    <h3 class="font-semibold text-lg text-yellow-800 mb-3">Tunggakan Insentif Wali Kelas</h3>
    @if($insentifWalasBelumDibayar->isEmpty())
        <p class="text-gray-500">Tidak ada tunggakan insentif untuk wali kelas.</p>
    @else
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-yellow-100">
                <tr>
                    <th class="px-4 py-2 text-left text-xs font-medium text-yellow-700 uppercase">Kelas</th>
                    <th class="px-4 py-2 text-left text-xs font-medium text-yellow-700 uppercase">Jumlah Tunggakan</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                @foreach($insentifWalasBelumDibayar as $item)
                <tr>
                    <td class="px-4 py-2 whitespace-nowrap">{{ $item->kelas->nama_kelas ?? 'Kelas Dihapus' }}</td>
                    <td class="px-4 py-2 whitespace-nowrap">Rp {{ number_format($item->total_tunggakan, 0, ',', '.') }}</td>
                </tr>
                @endforeach
            </tbody>
            <tfoot class="bg-yellow-100 font-bold">
                <tr>
                    <td class="px-4 py-2 text-right">Total Tunggakan</td>
                    <td class="px-4 py-2">Rp {{ number_format($totalTunggakanWalas, 0, ',', '.') }}</td>
                </tr>
            </tfoot>
        </table>
    @endif
</div>