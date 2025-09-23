<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Proses Tutup Buku Bulanan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                
                @if (isset($pesan))
                    <div class="p-4 mb-4 text-sm text-blue-700 bg-blue-100 rounded-lg" role="alert">
                        <span class="font-medium">Informasi:</span> {{ $pesan }}
                    </div>
                @else
                    <h3 class="text-lg font-bold text-gray-800">Konfirmasi Tutup Buku</h3>
                    <p class="text-sm text-gray-600 mb-4">
                        Anda akan menutup buku untuk periode: 
                        <strong class="text-blue-600">{{ $periode->isoFormat('MMMM YYYY') }}</strong>. 
                        Setelah dikonfirmasi, transaksi pada periode ini akan diarsipkan.
                    </p>

                    <div class="border rounded-lg p-4 space-y-3">
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600">Saldo Awal Periode</span>
                            <span class="font-semibold text-gray-800">Rp {{ number_format($saldoAwal, 0, ',', '.') }}</span>
                        </div>
                        <div class="flex justify-between items-center text-green-600">
                            <span class="">Total Pemasukan</span>
                            <span class="font-semibold">+ Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</span>
                        </div>
                        <div class="flex justify-between items-center text-red-600">
                            <span class="">Total Pengeluaran</span>
                            <span class="font-semibold">- Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</span>
                        </div>
                        <hr>
                        <div class="flex justify-between items-center text-xl">
                            <span class="font-bold text-gray-800">Saldo Akhir Periode</span>
                            <span class="font-bold text-blue-700">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</span>
                        </div>
                    </div>

                    <form action="{{ route('tutup-buku.store') }}" method="POST" onsubmit="return confirm('Anda yakin ingin menutup buku untuk periode ini? Proses ini tidak dapat dibatalkan.')">
                        @csrf
                        <input type="hidden" name="periode" value="{{ $periode->toDateString() }}">
                        <input type="hidden" name="saldo_awal" value="{{ $saldoAwal }}">
                        <input type="hidden" name="total_pemasukan" value="{{ $totalPemasukan }}">
                        <input type="hidden" name="total_pengeluaran" value="{{ $totalPengeluaran }}">
                        <input type="hidden" name="saldo_akhir" value="{{ $saldoAkhir }}">

                        <div class="flex justify-end mt-6">
                            <x-primary-button>
                                {{ __('Konfirmasi & Tutup Buku') }}
                            </x-primary-button>
                        </div>
                    </form>
                @endif

            </div>
        </div>
    </div>
</x-app-layout>