<div class="bg-gray-50 p-4 rounded-lg border">
     <h3 class="font-semibold text-lg mb-3">Rekap Pengeluaran Riil</h3>
     <ul class="space-y-3">
        <li class="flex justify-between items-center text-gray-700">
            <span>Insentif Wali Kelas (Sudah Dibayar)</span>
            <span class="font-bold">Rp {{ number_format($totalInsentifWalasSudahDibayar, 0, ',', '.') }}</span>
        </li>
        <li class="flex justify-between items-center text-gray-700">
            <span>Honor Sekolah & Pengelola</span>
            <span class="font-bold">Rp {{ number_format($totalHonorSekolah, 0, ',', '.') }}</span>
        </li>
        <li class="flex justify-between items-center text-gray-700">
            <span>Pengeluaran Operasional Lainnya</span>
            <span class="font-bold">Rp {{ number_format($totalPengeluaranOperasional, 0, ',', '.') }}</span>
        </li>
        <li class="border-t pt-3 mt-3 flex justify-between items-center font-semibold text-black">
            <span>Total Pengeluaran Keseluruhan</span>
            <span class="text-xl">Rp {{ number_format($totalPengeluaranRiil, 0, ',', '.') }}</span>
        </li>
     </ul>
</div>