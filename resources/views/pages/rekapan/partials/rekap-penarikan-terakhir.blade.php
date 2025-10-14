<div class="bg-gray-50 p-4 rounded-lg border">
    <h3 class="font-semibold text-lg mb-3">5 Penarikan Terakhir (Disetujui)</h3>
    @if($penarikanTerakhir->isEmpty())
        <p class="text-gray-500">Belum ada data penarikan.</p>
    @else
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-100">
                <tr>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Nama Penarik</th>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jumlah</th>
                    <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Tanggal</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                @foreach($penarikanTerakhir as $item)
                <tr>
                    <td class="px-4 py-2 whitespace-nowrap text-sm">{{ $item->siswa->pengguna->nama_lengkap ?? 'N/A' }}</td>
                    <td class="px-4 py-2 whitespace-nowrap text-sm">Rp {{ number_format($item->jumlah_penarikan, 0, ',', '.') }}</td>
                    <td class="px-4 py-2 whitespace-nowrap text-sm">{{ \Carbon\Carbon::parse($item->created_at)->isoFormat('D MMM YYYY') }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>
    @endif
</div>