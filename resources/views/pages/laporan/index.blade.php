<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Laporan') }}</h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                <form action="{{ route('laporan.index') }}" method="GET" class="mb-6">
                    <div class="flex flex-wrap items-center gap-4">
                        <div class="flex items-center space-x-2">
                            <x-text-input type="date" name="start_date" :value="$startDate" />
                            <span class="text-gray-500">s/d</span>
                            <x-text-input type="date" name="end_date" :value="$endDate" />
                        </div>
                        <x-primary-button type="submit">Filter</x-primary-button>
                    </div>
                </form>

                <div class="mb-8 p-4 border border-gray-200 rounded-lg">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-medium text-gray-900">Laporan Transaksi (Setoran & Penarikan)</h3>
                        <div class="flex items-center space-x-2">
                             <a href="{{ route('laporan.transaksi.export.excel', request()->query()) }}" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                Excel
                            </a>
                            <a href="{{ route('laporan.transaksi.export.pdf', request()->query()) }}" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                                PDF
                            </a>
                        </div>
                    </div>
                    @include('pages.laporan.partials.tabel-transaksi')
                </div>

                <div class="mb-8 p-4 border border-gray-200 rounded-lg">
                     <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-medium text-gray-900">Laporan Penjualan Sampah</h3>
                        <div class="flex items-center space-x-2">
                             <a href="{{ route('laporan.penjualan.export.excel', request()->query()) }}" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                Excel
                            </a>
                            <a href="{{ route('laporan.penjualan.export.pdf', request()->query()) }}" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                                PDF
                            </a>
                        </div>
                    </div>
                    @include('pages.laporan.partials.tabel-penjualan')
                </div>

                <div class="p-4 border border-gray-200 rounded-lg">
                     <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-medium text-gray-900">Laporan Laba Rugi</h3>
                        <div class="flex items-center space-x-2">
                            <a href="{{ route('laporan.laba-rugi.export.pdf', request()->query()) }}" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                                PDF
                            </a>
                        </div>
                    </div>
                    @include('pages.laporan.partials.laporan-laba-rugi')
                </div>
            </div>
        </div>
    </div>
</x-app-layout>