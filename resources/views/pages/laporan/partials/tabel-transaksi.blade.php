<div>
    <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200">
            Laporan Transaksi Bulan: {{ \Carbon\Carbon::parse($selectedMonth)->format('F Y') }}
        </h3>
        <a href="{{ route('laporan.transaksi.export.pdf', ['bulan' => $selectedMonth]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
            Export to PDF
        </a>
    </div>

    <h4 class="mb-2 font-semibold text-md dark:text-gray-200">Setoran</h4>
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg mb-6">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            {{-- ... table header ... --}}
            <tbody>
                {{-- PERBAIKAN: Mengganti $setoran menjadi $setorans --}}
                @forelse ($setorans as $item)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ $item->created_at->format('d-m-Y') }}</td>
                    <td class="px-6 py-4">{{ $item->siswa->nama }}</td>
                    <td class="px-6 py-4">{{ $item->jenisSampah->nama }}</td>
                    <td class="px-6 py-4">{{ $item->berat }} kg</td>
                    <td class="px-6 py-4">Rp {{ number_format($item->total, 2, ',', '.') }}</td>
                </tr>
                @empty
                <tr>
                    <td colspan="5" class="px-6 py-4 text-center">Tidak ada data setoran untuk bulan ini.</td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <h4 class="mb-2 font-semibold text-md dark:text-gray-200">Penarikan</h4>
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
           {{-- ... table header ... --}}
            <tbody>
                @forelse ($penarikans as $item)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ $item->created_at->format('d-m-Y') }}</td>
                    <td class="px-6 py-4">{{ $item->siswa->nama }}</td>
                    <td class="px-6 py-4">Rp {{ number_format($item->jumlah, 2, ',', '.') }}</td>
                </tr>
                @empty
                <tr>
                    <td colspan="3" class="px-6 py-4 text-center">Tidak ada data penarikan untuk bulan ini.</td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>