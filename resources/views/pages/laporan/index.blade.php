<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Laporan Keuangan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="p-6 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                
                <form action="{{ route('laporan.index') }}" method="GET" class="flex items-center mb-6 space-x-4">
                    <div>
                        <label for="bulan" class="sr-only">Pilih Bulan:</label>
                        {{-- PERBAIKAN: Menggunakan $selectedMonth untuk menampilkan judul laporan --}}
                        <input type="month" id="bulan" name="bulan" value="{{ $selectedMonth }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white">
                    </div>
                    <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Filter</button>
                </form>

                <div x-data="{ activeTab: 'transaksi' }" class="w-full">
                    <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
                        <ul class="flex flex-wrap -mb-px text-sm font-medium text-center" id="myTab" data-tabs-toggle="#myTabContent" role="tablist">
                            <li class="mr-2" role="presentation">
                                <button @click="activeTab = 'transaksi'" :class="{ 'border-blue-500 text-blue-600': activeTab === 'transaksi', 'border-transparent hover:text-gray-600 hover:border-gray-300': activeTab !== 'transaksi' }" class="inline-block p-4 border-b-2 rounded-t-lg" type="button">Laporan Transaksi</button>
                            </li>
                            <li class="mr-2" role="presentation">
                                <button @click="activeTab = 'penjualan'" :class="{ 'border-blue-500 text-blue-600': activeTab === 'penjualan', 'border-transparent hover:text-gray-600 hover:border-gray-300': activeTab !== 'penjualan' }" class="inline-block p-4 border-b-2 rounded-t-lg" type="button">Laporan Penjualan</button>
                            </li>
                             <li class="mr-2" role="presentation">
                                <button @click="activeTab = 'laba-rugi'" :class="{ 'border-blue-500 text-blue-600': activeTab === 'laba-rugi', 'border-transparent hover:text-gray-600 hover:border-gray-300': activeTab !== 'laba-rugi' }" class="inline-block p-4 border-b-2 rounded-t-lg" type="button">Laporan Laba Rugi</button>
                            </li>
                        </ul>
                    </div>
                    
                    <div id="myTabContent">
                        <div x-show="activeTab === 'transaksi'" class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800">
                           @include('pages.laporan.partials.tabel-transaksi', ['setorans' => $setorans, 'penarikans' => $penarikans, 'selectedMonth' => $selectedMonth])
                        </div>
                        <div x-show="activeTab === 'penjualan'" class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800">
                           @include('pages.laporan.partials.tabel-penjualan', ['penjualans' => $penjualans, 'selectedMonth' => $selectedMonth])
                        </div>
                        <div x-show="activeTab === 'laba-rugi'" class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800">
                            @include('pages.laporan.partials.laporan-laba-rugi', [
                                'pendapatan' => $pendapatan, 
                                'beban' => $beban, 
                                'labaRugi' => $labaRugi, 
                                'selectedMonth' => $selectedMonth
                            ])
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>