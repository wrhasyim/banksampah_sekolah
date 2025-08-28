<div class="overflow-x-auto">
    <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50 dark:bg-gray-700">
            <tr>
                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Tanggal</th>
                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Nama Siswa</th>
                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Jenis Transaksi</th>
                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Jumlah</th>
            </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800">
            {{-- PERBAIKAN: Mengganti $setorans menjadi $setoran --}}
            @forelse ($setoran as $item)
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($item->tanggal_setor)->format('d/m/Y') }}</td>
                    <td class="px-6 py-4 whitespace-nowrap">{{ $item->siswa->pengguna->name }}</td>
                    <td class="px-6 py-4 whitespace-nowrap">Setoran</td>
                    <td class="px-6 py-4 whitespace-nowrap">Rp. {{ number_format($item->total_harga) }}</td>
                </tr>
            @empty
                {{-- No setoran data --}}
            @endforelse

            @forelse ($penarikan as $item)
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($item->tanggal_penarikan)->format('d/m/Y') }}</td>
                    <td class="px-6 py-4 whitespace-nowrap">{{ $item->siswa->pengguna->name }}</td>
                    <td class="px-6 py-4 whitespace-nowrap">Penarikan</td>
                    <td class="px-6 py-4 whitespace-nowrap">Rp. {{ number_format($item->jumlah) }}</td>
                </tr>
            @empty
                {{-- No penarikan data --}}
            @endforelse

            @if ($setoran->isEmpty() && $penarikan->isEmpty())
                <tr>
                    <td colspan="4" class="px-6 py-4 text-center">Tidak ada data transaksi untuk periode ini.</td>
                </tr>
            @endif
        </tbody>
    </table>
</div>