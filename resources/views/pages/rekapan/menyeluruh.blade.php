{{-- resources/views/pages/rekapan/menyeluruh.blade.php --}}

<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Rekapitulasi Menyeluruh') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                        <div class="bg-green-100 p-6 rounded-lg shadow">
                            <h3 class="text-lg font-semibold text-green-800">Total Penjualan</h3>
                            <p class="text-3xl font-bold text-green-900">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
                        </div>
                        <div class="bg-red-100 p-6 rounded-lg shadow">
                            <h3 class="text-lg font-semibold text-red-800">Total Pengeluaran & Insentif</h3>
                            <p class="text-3xl font-bold text-red-900">Rp {{ number_format($totalPengeluaran + $totalInsentifWalas + $totalInsentifSekolah, 0, ',', '.') }}</p>
                        </div>
                        <div class="bg-blue-100 p-6 rounded-lg shadow">
                            <h3 class="text-lg font-semibold text-blue-800">Estimasi Kas Saat Ini</h3>
                            <p class="text-3xl font-bold text-blue-900">Rp {{ number_format($kas, 0, ',', '.') }}</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

                        <div class="space-y-6">
                            <div class="bg-gray-50 p-4 rounded-lg border">
                                <h3 class="font-semibold text-lg mb-3">Rekap Setoran Siswa</h3>
                                @if($setoranSiswa->isEmpty())
                                    <p class="text-gray-500">Belum ada data setoran siswa.</p>
                                @else
                                    <table class="min-w-full divide-y divide-gray-200">
                                        <thead class="bg-gray-100">
                                            <tr>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jenis Sampah</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jumlah (Kg)</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Total Harga</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200">
                                            @foreach($setoranSiswa as $item)
                                            <tr>
                                                <td class="px-4 py-2 whitespace-nowrap">{{ $item->jenis_sampah }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap">{{ $item->total_jumlah }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                @endif
                            </div>

                            <div class="bg-gray-50 p-4 rounded-lg border">
                                <h3 class="font-semibold text-lg mb-3">Rekap Setoran Guru</h3>
                                @if($setoranGuru->isEmpty())
                                     <p class="text-gray-500">Belum ada data setoran guru.</p>
                                @else
                                    <table class="min-w-full divide-y divide-gray-200">
                                        <thead class="bg-gray-100">
                                            <tr>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jenis Sampah</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Jumlah (Kg)</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Total Harga</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200">
                                            @foreach($setoranGuru as $item)
                                            <tr>
                                                <td class="px-4 py-2 whitespace-nowrap">{{ $item->jenis_sampah }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap">{{ $item->total_jumlah }}</td>
                                                <td class="px-4 py-2 whitespace-nowrap">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                @endif
                            </div>
                        </div>

                        <div class="bg-gray-50 p-4 rounded-lg border">
                             <h3 class="font-semibold text-lg mb-3">Rekap Pengeluaran</h3>
                             <ul class="space-y-3">
                                <li class="flex justify-between items-center text-gray-700">
                                    <span>Insentif Wali Kelas</span>
                                    <span class="font-bold">Rp {{ number_format($totalInsentifWalas, 0, ',', '.') }}</span>
                                </li>
                                <li class="flex justify-between items-center text-gray-700">
                                    <span>Insentif Sekolah</span>
                                    <span class="font-bold">Rp {{ number_format($totalInsentifSekolah, 0, ',', '.') }}</span>
                                </li>
                                <li class="flex justify-between items-center text-gray-700">
                                    <span>Pengeluaran Operasional</span>
                                    <span class="font-bold">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</span>
                                </li>
                                <li class="border-t pt-3 mt-3 flex justify-between items-center font-semibold text-black">
                                    <span>Total Pengeluaran Keseluruhan</span>
                                    <span class="text-xl">Rp {{ number_format($totalPengeluaran + $totalInsentifWalas + $totalInsentifSekolah, 0, ',', '.') }}</span>
                                </li>
                             </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>