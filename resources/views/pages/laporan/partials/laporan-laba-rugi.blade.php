<div class="bg-gray-50 p-6 rounded-lg shadow-md">
    <h3 class="text-lg font-semibold text-gray-800 mb-4">Laporan Laba Rugi</h3>
    <p class="text-sm text-gray-600 mb-6">
        Menampilkan ringkasan finansial berdasarkan filter tanggal yang Anda pilih. Jika tidak ada filter, akan menampilkan data keseluruhan.
    </p>

    <div class="space-y-4">
        <div class="flex justify-between items-center p-4 bg-green-100 rounded-md">
            <span class="font-medium text-green-800">Total Pemasukan (dari Penjualan)</span>
            <span class="font-bold text-lg text-green-800">
                Rp {{ number_format($labaRugi['total_penjualan'], 0, ',', '.') }}
            </span>
        </div>

        <div class="flex justify-between items-center p-4 bg-red-100 rounded-md">
            <span class="font-medium text-red-800">Total Pengeluaran (Penarikan Saldo Siswa)</span>
            <span class="font-bold text-lg text-red-800">
                - Rp {{ number_format($labaRugi['total_penarikan'], 0, ',', '.') }}
            </span>
        </div>

        <hr class="border-gray-300">

        <div class="flex justify-between items-center p-4 bg-blue-100 rounded-md">
            <span class="font-medium text-blue-800">Laba / Rugi Bersih</span>
            <span class="font-bold text-xl text-blue-800">
                Rp {{ number_format($labaRugi['laba_bersih'], 0, ',', '.') }}
            </span>
        </div>
    </div>
</div>