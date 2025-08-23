<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buku Tabungan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium">Halo, {{ $siswa->pengguna->nama_lengkap }}!</h3>
                    <p class="mt-4 text-gray-600">Total Saldo Tabungan Anda:</p>
                    <p class="text-4xl font-bold text-green-600">Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium mb-4">Riwayat Transaksi</h3>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3">Tanggal</th>
                                    <th class="px-6 py-3">Deskripsi</th>
                                    <th class="px-6 py-3">Pemasukan (Kredit)</th>
                                    <th class="px-6 py-3">Pengeluaran (Debit)</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($transaksi as $trx)
                                <tr class="bg-white border-b">
                                    <td class="px-6 py-4">{{ $trx->tanggal->format('d M Y, H:i') }}</td>
                                    <td class="px-6 py-4">{{ $trx->deskripsi }}</td>
                                    <td class="px-6 py-4 text-green-600 font-semibold">
                                        @if($trx->kredit > 0)
                                            + Rp {{ number_format($trx->kredit, 0, ',', '.') }}
                                        @endif
                                    </td>
                                    <td class="px-6 py-4 text-red-600 font-semibold">
                                        @if($trx->debit > 0)
                                            - Rp {{ number_format($trx->debit, 0, ',', '.') }}
                                        @endif
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-4 text-center">Anda belum memiliki riwayat transaksi.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>