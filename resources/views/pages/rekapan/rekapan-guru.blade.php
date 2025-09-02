<x-app-layout>
    <x-slot name="header">
        <div class="flex justify-between items-center">
            <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
                {{ __('Rekapan Khusus Guru') }}
            </h2>
            <a href="{{ route('rekapan.exportGuruPdf') }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-500 focus:outline-none focus:border-red-700 focus:ring focus:ring-red-200 active:bg-red-600 disabled:opacity-25 transition">
                 <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                </svg>
                Export PDF
            </a>
        </div>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="mb-8 overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-4 text-lg font-semibold">Rekapan Guru Terlambat</h3>
                    {{-- ... (salin tabel dari view rekapan siswa, tapi gunakan variabel $setoranTerlambatGuru) ... --}}
                    <div class="mt-4">
                        {{ $setoranTerlambatGuru->links() }}
                    </div>
                </div>
            </div>

            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-4 text-lg font-semibold">Rekapan Guru Tanpa Pendamping</h3>
                    {{-- ... (salin tabel dari view rekapan siswa, tapi gunakan variabel $setoranTanpaWaliKelasGuru) ... --}}
                     <div class="mt-4">
                        {{ $setoranTanpaWaliKelasGuru->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>