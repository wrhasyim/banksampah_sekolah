<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
    <div class="bg-green-100 p-6 rounded-lg shadow">
        <h3 class="text-lg font-semibold text-green-800">Total Penjualan</h3>
        <p class="text-3xl font-bold text-green-900">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
    </div>
    <div class="bg-red-100 p-6 rounded-lg shadow">
        <h3 class="text-lg font-semibold text-red-800">Total Pengeluaran Riil</h3>
        <p class="text-3xl font-bold text-red-900">Rp {{ number_format($totalPengeluaranRiil, 0, ',', '.') }}</p>
    </div>
    <div class="bg-blue-100 p-6 rounded-lg shadow">
        <h3 class="text-lg font-semibold text-blue-800">Estimasi Kas Saat Ini</h3>
        <p class="text-3xl font-bold text-blue-900">Rp {{ number_format($kas, 0, ',', '.') }}</p>
    </div>
</div>

<div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
    <div class="space-y-6">
        @include('pages.rekapan.partials.tabel-setoran-siswa')
        @include('pages.rekapan.partials.tabel-setoran-guru')
        @include('pages.rekapan.partials.rekap-pengeluaran-riil')
        @include('pages.rekapan.partials.rekap-penarikan-terakhir') 
    </div>
    
    <div class="space-y-6">
        
        @include('pages.rekapan.partials.tunggakan-insentif-walas')
    </div>
</div>