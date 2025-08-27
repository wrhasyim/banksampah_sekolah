<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Buku Kas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    {{-- content --}}
                    <div class="flex flex-col md:flex-row">
                        <div class="w-full mb-6 md:w-1/3 md:mb-0 md:mr-6">
                            <h3 class="mb-4 text-lg font-semibold">Tambah Transaksi</h3>
                            <form action="{{ route('buku-kas.store') }}" method="POST" class="p-4 bg-gray-100 rounded-lg dark:bg-gray-700">
                                @csrf
                                </form>
                        </div>

                        <div class="w-full md:w-2/3">
                            <div class="flex flex-col items-start justify-between gap-4 mb-4 md:flex-row md:items-center">
                                <form action="{{ route('buku-kas.index') }}" method="GET" class="flex items-center">
                                    </form>
                                <div class="flex items-center space-x-2">
                                    <a href="{{ route('buku-kas.export.excel', ['bulan' => $bulan, 'tahun' => $tahun]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-md hover:bg-green-700">
                                        Ekspor Excel
                                    </a>
                                    <a href="{{ route('buku-kas.export.pdf', ['bulan' => $bulan, 'tahun' => $tahun]) }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
                                        Ekspor PDF
                                    </a>
                                </div>
                            </div>
                            
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50 dark:bg-gray-700">
                                        <tr>
                                            <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Tanggal</th>
                                            <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Keterangan</th>
                                            <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Pemasukan</th>
                                            <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Pengeluaran</th>
                                            <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800">
                                        {{-- PERBAIKAN: Mengganti $transaksi menjadi $bukuKas --}}
                                        @forelse ($bukuKas as $item)
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap">{{ \Carbon\Carbon::parse($item->tanggal)->format('d/m/Y') }}</td>
                                                <td class="px-6 py-4 whitespace-nowrap">{{ $item->keterangan }}</td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    @if ($item->tipe == 'pemasukan')
                                                        Rp. {{ number_format($item->jumlah) }}
                                                    @endif
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    @if ($item->tipe == 'pengeluaran')
                                                        Rp. {{ number_format($item->jumlah) }}
                                                    @endif
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <form action="{{ route('buku-kas.destroy', $item->id) }}" method="POST">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="submit" class="text-red-600 hover:text-red-900" onclick="return confirm('Yakin ingin menghapus?')">Hapus</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        @empty
                                            <tr>
                                                <td colspan="5" class="px-6 py-4 text-center">Tidak ada data untuk periode ini.</td>
                                            </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>