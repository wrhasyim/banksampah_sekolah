<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Detail Penjualan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <div class="flex justify-between items-start">
                        <div>
                            <h3 class="text-lg font-semibold">Transaksi #{{ $penjualan->id }}</h3>
                            <p class="text-sm text-gray-600">{{ $penjualan->created_at->format('d F Y, H:i') }}</p>
                        </div>
                        <a href="{{ route('penjualan.index') }}" class="text-sm text-indigo-600 hover:text-indigo-900">&larr; Kembali ke Histori</a>
                    </div>
                    
                    <div class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <h4 class="font-semibold">Nama Pengepul:</h4>
                            <p>{{ $penjualan->nama_pengepul }}</p>
                        </div>
                        <div>
                            <h4 class="font-semibold">Dicatat oleh Admin:</h4>
                            <p>{{ $penjualan->admin->nama_lengkap }}</p>
                        </div>
                    </div>
                    
                    <div class="mt-8">
                        <h4 class="font-semibold mb-4">Item yang Terjual:</h4>
                        <div class="relative overflow-x-auto border rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3">Nama Sampah</th>
                                        <th class="px-6 py-3 text-center">Jumlah</th>
                                        <th class="px-6 py-3 text-right">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($penjualan->detailPenjualan as $detail)
                                    <tr class="bg-white border-b">
                                        <td class="px-6 py-4">{{ $detail->jenisSampah->nama_sampah }}</td>
                                        <td class="px-6 py-4 text-center">{{ $detail->jumlah_satuan }} pcs</td>
                                        <td class="px-6 py-4 text-right">Rp {{ number_format($detail->subtotal_harga, 0, ',', '.') }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                                <tfoot class="bg-gray-50">
                                    <tr>
                                        <th colspan="2" class="px-6 py-3 text-right font-bold text-base text-gray-900">Total Penjualan</th>
                                        <td class="px-6 py-3 text-right font-bold text-base text-gray-900">Rp {{ number_format($penjualan->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>