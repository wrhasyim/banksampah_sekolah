<div class="max-w-md mx-auto bg-white shadow-md sm:rounded-lg p-6">
    <div class="space-y-4">
        <div class="flex justify-between items-center pb-2 border-b">
            <span class="text-gray-600">Total Pendapatan</span>
            <span class="font-semibold text-green-600">
                Rp {{ number_format($pendapatan, 0, ',', '.') }}
            </span>
        </div>

        <div class="flex justify-between items-center pb-2 border-b">
            <span class="text-gray-600">Total Beban Operasional</span>
            <span class="font-semibold text-red-600">
                Rp {{ number_format($beban, 0, ',', '.') }}
            </span>
        </div>

        <div class="flex justify-between items-center pt-2">
            <span class="font-bold text-gray-800">Laba / Rugi Bersih</span>
            <span class="font-bold text-lg {{ $labaRugi >= 0 ? 'text-green-700' : 'text-red-700' }}">
                Rp {{ number_format($labaRugi, 0, ',', '.') }}
            </span>
        </div>
    </div>
</div>