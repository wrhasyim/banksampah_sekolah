<div>
    {{-- PERBAIKAN: Form filter dipindahkan, di sini hanya menampilkan data --}}
    <div class="flex items-center justify-between mb-4">
         <p class="text-sm text-gray-600 dark:text-gray-400">
            Menampilkan laba/rugi untuk periode: <strong>{{ \Carbon\Carbon::parse($startLabaRugi)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endLabaRugi)->isoFormat('D MMMM Y') }}</strong>
        </p>
        {{-- PERBAIKAN: Tautan Export PDF membawa filter tanggal yang aktif --}}
        <a href="{{ route('laporan.laba-rugi.export.pdf', ['start_date_laba_rugi' => $startLabaRugi, 'end_date_laba_rugi' => $endLabaRugi]) }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700 focus:ring-4 focus:ring-red-300 dark:bg-red-500 dark:hover:bg-red-600">
            Export PDF
        </a>
    </div>

    <div class="mt-6 border-t border-gray-200 dark:border-gray-700">
        <dl class="divide-y divide-gray-200 dark:divide-gray-700">
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Penjualan (Pendapatan)</dt>
                <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100 sm:mt-0 sm:col-span-2">Rp. {{ number_format($totalPenjualan, 0, ',', '.') }}</dd>
            </div>
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Insentif Terbayar</dt>
                <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100 sm:mt-0 sm:col-span-2">Rp. {{ number_format($totalInsentif, 0, ',', '.') }}</dd>
            </div>
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Pengeluaran Lainnya (dari Buku Kas)</dt>
                <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100 sm:mt-0 sm:col-span-2">Rp. {{ number_format($pengeluaranLain, 0, ',', '.') }}</dd>
            </div>
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 bg-gray-50 dark:bg-gray-700">
                <dt class="text-sm font-bold text-gray-900 dark:text-white">Laba / Rugi Bersih</dt>
                <dd class="mt-1 text-sm font-bold text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">Rp. {{ number_format($labaRugi, 0, ',', '.') }}</dd>
            </div>
        </dl>
    </div>
</div>