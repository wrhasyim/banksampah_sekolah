<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Laporan Rinci Setoran Terlambat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">

                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-bold text-gray-800">Daftar Transaksi Setoran Terlambat</h3>
                    {{-- Tombol Ekspor mengarah ke route yang benar --}}
                    <a href="{{ route('rekapan.siswa.terlambat.exportPdf') }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-500 active:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition ease-in-out duration-150">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                        </svg>
                        Export PDF
                    </a>
                </div>

                <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                    <table class="w-full text-sm text-left text-gray-500">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                            <tr>
                                <th class="px-6 py-3">No</th>
                                <th class="px-6 py-3">Tanggal</th>
                                <th class="px-6 py-3">Nama Siswa</th>
                                <th class="px-6 py-3">Kelas</th>
                                <th class="px-6 py-3">Jenis Sampah</th>
                                <th class="px-6 py-3">Jumlah</th>
                                <th class="px-6 py-3 text-right">Total Harga</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($setoranTerlambat as $item)
                                <tr class="bg-white border-b hover:bg-gray-50">
                                    {{-- Nomor urut disesuaikan dengan paginasi --}}
                                    <th class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                                        {{ $loop->iteration + $setoranTerlambat->firstItem() - 1 }}
                                    </th>
                                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->created_at)->isoFormat('D MMM YYYY, HH:mm') }}</td>
                                    <td class="px-6 py-4">{{ $item->siswa->pengguna->nama_lengkap }}</td>
                                    <td class="px-6 py-4">{{ $item->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                                    <td class="px-6 py-4">{{ $item->jenisSampah->nama_sampah }}</td>
                                    <td class="px-6 py-4">{{ $item->jumlah }} {{ $item->jenisSampah->satuan }}</td>
                                    <td class="px-6 py-4 text-right">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="px-6 py-12 text-center text-gray-500">
                                        Tidak ada data setoran terlambat.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>

                {{-- Link Paginasi --}}
                @if ($setoranTerlambat->hasPages())
                    <div class="mt-4">
                        {{ $setoranTerlambat->links() }}
                    </div>
                @endif
                
            </div>
        </div>
    </div>
</x-app-layout>