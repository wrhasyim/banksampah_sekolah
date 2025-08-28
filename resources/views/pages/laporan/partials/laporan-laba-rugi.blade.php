<div class="p-4 border rounded-lg">
    <div class="flex justify-between mb-2">
        <span class="font-semibold">Total Pemasukan:</span>
        {{-- PERBAIKAN: Mengganti $pendapatan menjadi $pemasukan --}}
        <span class="text-green-600">Rp {{ number_format($pemasukan, 0, ',', '.') }}</span>
    </div>
    <div class="flex justify-between pb-2 mb-2 border-b">
        <span class="font-semibold">Total Pengeluaran:</span>
        <span class="text-red-600">Rp {{ number_format($pengeluaran, 0, ',', '.') }}</span>
    </div>
    <div class="flex justify-between font-bold">
        <span>Laba Rugi:</span>
        @php
            $labaRugi = $pemasukan - $pengeluaran;
        @endphp
        <span class="{{ $labaRugi >= 0 ? 'text-green-600' : 'text-red-600' }}">
            Rp {{ number_format($labaRugi, 0, ',', '.') }}
        </span>
    </div>
</div>