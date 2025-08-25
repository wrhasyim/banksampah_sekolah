<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Detail Transaksi Penjualan') }}
        </h2>
    </x-slot>

    {{-- Menambahkan CSS Khusus untuk Print yang Sudah Diperbaiki --}}
    @push('styles')
    <style>
        @media print {
            /* 1. Sembunyikan semua elemen secara default */
            body * {
                visibility: hidden;
            }
            /* 2. Perlihatkan hanya area faktur dan semua elemen di dalamnya */
            .invoice-area, .invoice-area * {
                visibility: visible;
            }
            /* 3. Atur posisi area faktur agar mengisi seluruh halaman cetak */
            .invoice-area {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }
            /* Tombol-tombol tetap disembunyikan */
            .no-print {
                display: none;
            }
        }
    </style>
    @endpush

    <div class="py-12">
        {{-- Tambahkan class "invoice-area" agar bisa dipilih oleh CSS print --}}
        <div class="max-w-4xl mx-auto sm:px-6 lg:px-8 invoice-area">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 md:p-8 bg-white border-b border-gray-200">

                    <div class="flex justify-between items-start">
                        <div>
                            <h3 class="text-2xl font-bold text-gray-800">FAKTUR PENJUALAN</h3>
                            <p class="text-sm text-gray-500">Transaksi #{{ $penjualan->id }}</p>
                        </div>
                        <div class="text-right">
                            <p class="text-sm font-semibold text-gray-800">{{ $siteSettings['site_title'] ?? config('app.name', 'Laravel') }}</p>
                            <p class="text-xs text-gray-500">Bank Sampah Sekolah</p>
                        </div>
                    </div>

                    <div class="my-6 border-t border-gray-200"></div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 text-sm">
                        <div>
                            <p class="text-gray-500 mb-1">Tanggal Transaksi</p>
                            <p class="font-semibold">{{ $penjualan->created_at->format('d F Y') }}</p>
                        </div>
                        <div>
                            <p class="text-gray-500 mb-1">Dijual Kepada</p>
                            <p class="font-semibold">{{ $penjualan->nama_pengepul }}</p>
                        </div>
                        <div>
                            <p class="text-gray-500 mb-1">Dicatat oleh</p>
                            <p class="font-semibold">{{ $penjualan->admin?->nama_lengkap ?? 'Admin Dihapus' }}</p>
                        </div>
                    </div>
                    
                    <div class="mt-8">
                        <h4 class="font-semibold mb-4">Item yang Terjual:</h4>
                        <div class="relative overflow-x-auto border rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3">Item Sampah</th>
                                        <th class="px-6 py-3 text-center">Jumlah</th>
                                        <th class="px-6 py-3 text-right">Harga Jual</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($penjualan->detailPenjualan as $detail)
                                    <tr class="bg-white border-b">
                                        <td class="px-6 py-4 font-medium text-gray-900">{{ $detail->jenisSampah?->nama_sampah ?? '[Sampah Dihapus]' }}</td>
                                        <td class="px-6 py-4 text-center">{{ $detail->jumlah }} {{ $detail->jenisSampah?->satuan }}</td>
                                        <td class="px-6 py-4 text-right">Rp {{ number_format($detail->subtotal_harga, 0, ',', '.') }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="mt-6 flex justify-end">
                        <div class="w-full max-w-xs">
                            <div class="flex justify-between py-2">
                                <span class="text-gray-600">Subtotal</span>
                                <span class="font-medium">Rp {{ number_format($penjualan->total_harga, 0, ',', '.') }}</span>
                            </div>
                            <div class="flex justify-between py-2 border-t-2 border-gray-200 mt-2">
                                <span class="font-bold text-lg text-gray-900">TOTAL</span>
                                <span class="font-bold text-lg text-indigo-600">Rp {{ number_format($penjualan->total_harga, 0, ',', '.') }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-8 flex justify-between items-center no-print">
                         <a href="{{ route('penjualan.index') }}" class="text-sm text-indigo-600 hover:text-indigo-900">&larr; Kembali ke Histori</a>
                         <button onclick="window.print()" class="px-4 py-2 bg-gray-800 text-white rounded-md text-xs uppercase font-semibold">Cetak Faktur</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

</x-app-layout>