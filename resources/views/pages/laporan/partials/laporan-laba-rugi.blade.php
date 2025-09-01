<div>
    <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-200">
            Laporan Laba Rugi Bulan: {{ \Carbon\Carbon::parse($selectedMonth)->isoFormat('MMMM YYYY') }}
        </h3>
        <a href="{{ route('laporan.laba-rugi.export.pdf', ['bulan' => $selectedMonth]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
            Export to PDF
        </a>
    </div>

    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">Deskripsi</th>
                    <th scope="col" class="px-6 py-3">Jumlah</th>
                </tr>
            </thead>
            <tbody>
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4 font-medium">Total Pendapatan (dari Penjualan)</td>
                    <td class="px-6 py-4 text-green-600">Rp {{ number_format($pendapatan, 0, ',', '.') }}</td>
                </tr>
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    {{-- --- PERBAIKAN LABEL DI SINI --- --}}
                    <td class="px-6 py-4 font-medium">Total Beban (Penarikan, Honor, dll)</td>
                    <td class="px-6 py-4 text-red-600">- Rp {{ number_format($beban, 0, ',', '.') }}</td>
                </tr>
                <tr class="bg-white dark:bg-gray-800">
                    <td class="px-6 py-4 text-lg font-bold">Laba / Rugi Bersih</td>
                    <td class="px-6 py-4 text-lg font-bold {{ $labaRugi >= 0 ? 'text-green-600' : 'text-red-600' }}">
                        Rp {{ number_format($labaRugi, 0, ',', '.') }}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>