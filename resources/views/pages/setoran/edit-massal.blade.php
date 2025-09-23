<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Edit Setoran Secara Massal') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <form action="{{ route('setoran.update.massal') }}" method="POST">
                    @csrf
                    {{-- Menggunakan method POST karena form HTML tidak secara native mendukung PUT/PATCH --}}
                    {{-- Logika di controller akan menangani pembaruan --}}

                    <div class="p-6 text-gray-900 dark:text-gray-100">
                        <div class="mb-4 p-4 bg-yellow-50 dark:bg-yellow-900/50 border-l-4 border-yellow-500 text-yellow-800 dark:text-yellow-300">
                            <p class="font-bold">Perhatian!</p>
                            <p class="text-sm">Ubah jumlah, jenis sampah, atau tandai data untuk dihapus. Semua perubahan akan memperbarui saldo siswa, stok sampah, dan insentif terkait secara otomatis.</p>
                        </div>
                        
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">Siswa</th>
                                        <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                        <th scope="col" class="px-6 py-3">Jumlah</th>
                                        <th scope="col" class="px-6 py-3 text-center">Tandai untuk Hapus</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                                    @foreach($setorans as $setoran)
                                        <tr class="align-top">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                {{ $setoran->siswa->pengguna->nama_lengkap }}
                                            </td>
                                            <td class="px-6 py-4">
                                                <select name="setoran[{{ $setoran->id }}][jenis_sampah_id]" class="w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 rounded-md shadow-sm text-sm">
                                                    @foreach($jenisSampahs as $jenis)
                                                        <option value="{{ $jenis->id }}" {{ $setoran->jenis_sampah_id == $jenis->id ? 'selected' : '' }}>
                                                            {{ $jenis->nama_sampah }}
                                                        </option>
                                                    @endforeach
                                                </select>
                                            </td>
                                            <td class="px-6 py-4">
                                                <x-text-input type="number" step="0.01" name="setoran[{{ $setoran->id }}][jumlah]" value="{{ $setoran->jumlah }}" class="w-full text-sm" />
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <input type="checkbox" name="hapus[{{ $setoran->id }}]" class="h-6 w-6 rounded border-gray-300 text-red-600 focus:ring-red-500 dark:bg-gray-900 dark:border-gray-700 dark:focus:ring-offset-gray-800">
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="flex items-center justify-end mt-6">
                            <a href="{{ route('setoran.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-200 dark:bg-gray-600 border border-transparent rounded-md font-semibold text-xs text-gray-800 dark:text-gray-200 uppercase tracking-widest hover:bg-gray-300 dark:hover:bg-gray-500">
                                {{ __('Batal') }}
                            </a>
                            <x-primary-button class="ml-4 bg-green-600 hover:bg-green-700">
                                {{ __('Simpan Semua Perubahan') }}
                            </x-primary-button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>