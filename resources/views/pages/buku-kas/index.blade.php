<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Buku Kas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="p-6 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">

                <form action="{{ route('buku-kas.index') }}" method="GET" class="mb-6">
                    <div class="flex flex-col md:flex-row md:items-center md:space-x-4">
                        <div class="flex-1">
                            <label for="bulan" class="sr-only">Pilih Bulan:</label>
                            <input type="month" id="bulan" name="bulan" value="{{ $selectedMonth }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white">
                        </div>
                        <div class="flex items-center mt-4 space-x-2 md:mt-0">
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Filter</button>
                            <a href="{{ route('buku-kas.export.excel', ['bulan' => $selectedMonth]) }}" class="px-4 py-2 text-white bg-green-600 rounded-md hover:bg-green-700">Export Excel</a>
                            <a href="{{ route('buku-kas.export.pdf', ['bulan' => $selectedMonth]) }}" class="px-4 py-2 text-white bg-red-600 rounded-md hover:bg-red-700">Export PDF</a>
                        </div>
                    </div>
                </form>

                <div x-data="{ open: false }">
                    <button @click="open = !open" class="mb-4 inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-700 border border-transparent rounded-md hover:bg-gray-800">
                        Tambah Transaksi
                    </button>
                    <div x-show="open" @click.away="open = false" class="p-4 mb-6 bg-gray-100 rounded-lg dark:bg-gray-700" style="display: none;">
                        @include('pages.buku-kas.partials.create-form')
                    </div>
                </div>

                @include('pages.buku-kas.partials.table')
                
                {{-- --- TAMBAHAN DI SINI: Menampilkan Link Paginasi --- --}}
                <div class="mt-6">
                    {{ $bukuKas->links() }}
                </div>

            </div>
        </div>
    </div>
</x-app-layout>