<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Data Setoran') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <div class="flex flex-col md:flex-row justify-between items-center mb-6 gap-4">
                        <h3 class="text-lg font-semibold text-center md:text-left">Daftar Setoran Sampah</h3>
                        <div class="flex flex-wrap justify-center md:justify-end gap-2">
                          <a href="{{ route('setoran.create.massal') }}" class="inline-flex items-center px-4 py-2 bg-blue-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-600 active:bg-blue-700 focus:outline-none focus:border-blue-700 focus:ring ring-blue-300 disabled:opacity-25 transition ease-in-out duration-150">
                                <i class="fas fa-users mr-2"></i>Setoran Massal
                            </a>
                        </div>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3">Jumlah</th>
                                    <th scope="col" class="px-6 py-3">Total Harga</th>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($setoran as $item)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">
                                        {{ $item->siswa->pengguna->nama_lengkap ?? 'Siswa Telah Dihapus' }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{-- Tambahkan pengecekan ini --}}
    @if ($item->jenisSampah)
        {{ $item->jenisSampah->nama_sampah }}
    @else
        <span class="text-red-500">(Data Sampah Telah Dihapus)</span>
    @endif
                                    </td>
                                    <td class="px-6 py-4">
                                        {{-- PERBAIKAN 2: Menampilkan jumlah & satuan dinamis dari relasi --}}
                                        {{ $item->jumlah }} {{ $item->jenisSampah->satuan ?? '' }}
                                    </td>
                                    <td class="px-6 py-4">
                                        Rp. {{ number_format($item->total_harga, 0, ',', '.') }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $item->created_at->format('d-m-Y H:i') }}
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="5" class="px-6 py-4 text-center">Tidak ada data setoran.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{ $setoran->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>