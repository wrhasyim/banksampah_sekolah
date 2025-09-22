<div>
    {{-- Form Filter --}}
    <form method="GET" action="{{ route('laporan.index') }}" class="mb-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
                <label for="start_date_laba_rugi" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
                <input type="date" name="start_date_laba_rugi" id="start_date_laba_rugi" value="{{ $startLabaRugi }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
            </div>
            <div>
                <label for="end_date_laba_rugi" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
                <input type="date" name="end_date_laba_rugi" id="end_date_laba_rugi" value="{{ $endLabaRugi }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
            </div>
            <div class="flex items-end">
                <button type="submit" class="w-full inline-flex justify-center items-center px-4 py-2 bg-blue-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-600">Filter</button>
            </div>
        </div>
    </form>

    {{-- Tampilan Kartu Laba Rugi --}}
    <div class="mt-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="bg-green-50 dark:bg-green-800/20 p-6 rounded-lg shadow">
            <div class="flex items-center">
                <div class="flex-shrink-0 bg-green-500 rounded-md p-3">
                    <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 10v-1m0-11a9 9 0 110 18 9 9 0 010-18z" />
                    </svg>
                </div>
                <div class="ml-4">
                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400 truncate">Total Penjualan</p>
                    <p class="text-2xl font-semibold text-gray-900 dark:text-white">Rp. {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
                </div>
            </div>
        </div>

        <div class="bg-red-50 dark:bg-red-800/20 p-6 rounded-lg shadow">
            <div class="flex items-center">
                <div class="flex-shrink-0 bg-red-500 rounded-md p-3">
                     <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h1a2 2 0 002-2v-2a2 2 0 00-2-2H9a2 2 0 00-2 2v2a2 2 0 002 2h2m-2-4h2m2 4H9" />
                    </svg>
                </div>
                <div class="ml-4">
                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400 truncate">Total Insentif</p>
                    <p class="text-2xl font-semibold text-gray-900 dark:text-white">Rp. {{ number_format($totalInsentif, 0, ',', '.') }}</p>
                </div>
            </div>
        </div>

        <div class="bg-yellow-50 dark:bg-yellow-800/20 p-6 rounded-lg shadow">
            <div class="flex items-center">
                <div class="flex-shrink-0 bg-yellow-500 rounded-md p-3">
                    <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                </div>
                <div class="ml-4">
                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400 truncate">Pengeluaran Lain</p>
                    <p class="text-2xl font-semibold text-gray-900 dark:text-white">Rp. {{ number_format($pengeluaranLain, 0, ',', '.') }}</p>
                </div>
            </div>
        </div>
        
        <div class="{{ $labaRugi >= 0 ? 'bg-blue-50 dark:bg-blue-800/20' : 'bg-gray-50 dark:bg-gray-700/20' }} p-6 rounded-lg shadow">
            <div class="flex items-center">
                <div class="flex-shrink-0 {{ $labaRugi >= 0 ? 'bg-blue-500' : 'bg-gray-500' }} rounded-md p-3">
                   <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 17h8m0 0V9m0 8l-8-8-4 4-6-6" />
                    </svg>
                </div>
                <div class="ml-4">
                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400 truncate">Laba / Rugi Bersih</p>
                    <p class="text-2xl font-semibold {{ $labaRugi >= 0 ? 'text-blue-600 dark:text-blue-300' : 'text-gray-900 dark:text-white' }}">Rp. {{ number_format($labaRugi, 0, ',', '.') }}</p>
                </div>
            </div>
        </div>
    </div>
     <div class="mt-6 flex justify-end">
        <a href="{{ route('laporan.laba-rugi.export.pdf', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700">Export PDF</a>
    </div>
</div>