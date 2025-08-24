<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Dashboard Siswa') }}</h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                </div>

            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium mb-4">5 Transaksi Terakhir</h3>
                    <div class="relative overflow-x-auto">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3">Tanggal</th>
                                    <th class="px-6 py-3">Keterangan</th>
                                    <th class="px-6 py-3 text-right">Nominal</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($transaksiTerakhir as $trx)
                                <tr class="bg-white border-b">
                                    <td class="px-6 py-4">{{ $trx['data']->created_at->format('d M Y') }}</td>
                                    @if($trx['tipe'] == 'setoran')
                                        <td class="px-6 py-4">Setoran Sampah</td>
                                        <td class="px-6 py-4 text-right text-green-600 font-semibold">
                                            + Rp {{ number_format($trx['data']->total_harga, 0, ',', '.') }}
                                        </td>
                                    @else
                                        <td class="px-6 py-4">Penarikan Saldo</td>
                                        <td class="px-6 py-4 text-right text-red-600 font-semibold">
                                            - Rp {{ number_format($trx['data']->jumlah_penarikan, 0, ',', '.') }}
                                        </td>
                                    @endif
                                </tr>
                                @empty
                                <tr><td colspan="3" class="px-6 py-4 text-center">Belum ada transaksi.</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>