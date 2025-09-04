<div>
    <form method="GET" action="{{ route('laporan.index') }}" class="mb-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
                <label for="start_date_laba_rugi" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
                <input type="date" name="start_date_laba_rugi" id="start_date_laba_rugi" value="{{ request('start_date_laba_rugi', \Carbon\Carbon::now()->startOfMonth()->toDateString()) }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
            </div>
            <div>
                <label for="end_date_laba_rugi" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
                <input type="date" name="end_date_laba_rugi" id="end_date_laba_rugi" value="{{ request('end_date_laba_rugi', \Carbon\Carbon::now()->endOfMonth()->toDateString()) }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
            </div>
            <div class="flex items-end">
                <button type="submit" class="w-full inline-flex justify-center items-center px-4 py-2 bg-blue-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-600">Filter</button>
            </div>
        </div>
    </form>
    <div class="mt-4 flex justify-end">
        <a href="{{ route('laporan.laba-rugi.export.pdf', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700">Export PDF</a>
    </div>

    <div class="mt-6 border-t border-gray-200 dark:border-gray-700">
        <dl class="divide-y divide-gray-200 dark:divide-gray-700">
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Penjualan (Pendapatan)</dt>
                {{-- PERBAIKAN: Menggunakan $totalPenjualan, bukan $pendapatan --}}
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