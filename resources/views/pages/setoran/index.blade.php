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

                    <form action="{{ route('setoran.edit.massal') }}" method="GET">
                        <div class="mb-4">
                            <button type="submit" class="inline-flex items-center px-4 py-2 bg-yellow-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-yellow-600 active:bg-yellow-700 focus:outline-none focus:border-yellow-700 focus:ring ring-yellow-300 disabled:opacity-25 transition ease-in-out duration-150">
                                <i class="fas fa-edit mr-2"></i>Edit Massal Terpilih
                            </button>
                        </div>

                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="p-4">
                                            <input type="checkbox" id="select-all" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                        </th>
                                        <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                        <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                        <th scope="col" class="px-6 py-3">Jumlah</th>
                                        <th scope="col" class="px-6 py-3">Total Harga</th>
                                        <th scope="col" class="px-6 py-3">Tanggal</th>
                                       
                                    </tr>
                                </thead>
                                <tbody>
                                    {{-- PERBAIKAN 1: Menggunakan variabel $setorans (jamak) dari Controller --}}
                                    @forelse ($setorans as $item)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <td class="w-4 p-4">
                                            <input type="checkbox" name="setoran_ids[]" value="{{ $item->id }}" class="row-checkbox w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->siswa->pengguna->nama_lengkap ?? 'Siswa Telah Dihapus' }}
                                        </td>
                                        <td class="px-6 py-4">
                                            @if ($item->jenisSampah)
                                                {{ $item->jenisSampah->nama_sampah }}
                                            @else
                                                <span class="text-red-500">(Data Sampah Telah Dihapus)</span>
                                            @endif
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->jumlah }} {{ $item->jenisSampah->satuan ?? '' }}
                                        </td>
                                        <td class="px-6 py-4">
                                            Rp. {{ number_format($item->total_harga, 0, ',', '.') }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->created_at->format('d-m-Y H:i') }}
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            {{-- Aksi per baris jika diperlukan bisa ditambahkan di sini --}}
                                        </td>
                                    </tr>
                                    @empty
                                    <tr>
                                        <td colspan="7" class="px-6 py-4 text-center">Tidak ada data setoran.</td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </form> <div class="mt-4">
                        {{-- PERBAIKAN 2: Menggunakan variabel $setorans untuk links() --}}
                        {{ $setorans->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    @push('scripts')
    <script>
        // Script untuk fungsionalitas "select all" checkbox
        document.getElementById('select-all').addEventListener('click', function(event) {
            const checkboxes = document.querySelectorAll('.row-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = event.target.checked;
            });
        });
    </script>
    @endpush
</x-app-layout>