<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Edit Setoran Massal') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="text-lg font-medium text-gray-900 dark:text-gray-200 mb-4">Data yang akan diubah: ({{ count($setorans) }} data)</h3>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg mb-6">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Siswa</th>
                                    <th scope="col" class="px-6 py-3">Jenis Sampah (Lama)</th>
                                    <th scope="col" class="px-6 py-3">Jumlah</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($setorans as $setoran)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        {{-- PERBAIKAN 1: Mengakses relasi yang benar --}}
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jenisSampah->nama_sampah ?? 'Sampah Dihapus' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $setoran->jumlah }} {{ $setoran->jenisSampah->satuan ?? '' }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <form action="{{ route('setoran.update.massal') }}" method="POST">
                        @csrf
                        @foreach ($setoranIds as $id)
                            <input type="hidden" name="setoran_ids[]" value="{{ $id }}">
                        @endforeach

                        <div>
                            <x-input-label for="jenis_sampah_id" value="Ubah Jenis Sampah ke" />
                            <select id="jenis_sampah_id" name="jenis_sampah_id" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm" required>
                                <option value="">Pilih Jenis Sampah Baru</option>
                                {{-- PERBAIKAN 2: Menampilkan nama dan harga sampah yang benar --}}
                                @foreach ($jenisSampahs as $jenis)
                                    <option value="{{ $jenis->id }}">{{ $jenis->nama_sampah }} (Rp {{ number_format($jenis->harga_per_satuan, 0, ',', '.') }}/{{$jenis->satuan}})</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <a href="{{ route('setoran.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-200 dark:bg-gray-600 border border-transparent rounded-md font-semibold text-xs text-gray-800 dark:text-gray-200 uppercase tracking-widest hover:bg-gray-300 dark:hover:bg-gray-500">
                                {{ __('Batal') }}
                            </a>
                            <x-primary-button class="ml-4">
                                {{ __('Simpan Perubahan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>