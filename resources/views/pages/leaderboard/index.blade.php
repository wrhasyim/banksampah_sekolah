<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Leaderboard') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <form action="{{ route('leaderboard.index') }}" method="GET" class="mb-6">
                        <div class="grid grid-cols-1 gap-4 md:grid-cols-4">
                            
                            <div>
                                <label for="tanggal_mulai" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Mulai</label>
                                <input type="date" name="tanggal_mulai" id="tanggal_mulai"
                                       value="{{ $tanggal_mulai ?? '' }}"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                       required>
                            </div>

                            <div>
                                <label for="tanggal_akhir" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Akhir</label>
                                <input type="date" name="tanggal_akhir" id="tanggal_akhir"
                                       value="{{ $tanggal_akhir ?? '' }}"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                       required>
                            </div>

                            <div>
                                <label for="ranking_by" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Urutkan Berdasarkan</label>
                                <select name="ranking_by" id="ranking_by" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                    <option value="jumlah" {{ $rankingBy == 'jumlah' ? 'selected' : '' }}>
                                        Total Sampah (Pcs)
                                    </option>
                                    <option value="total_harga" {{ $rankingBy == 'total_harga' ? 'selected' : '' }}>
                                        Total Nominal (Rp)
                                    </option>
                                </select>
                            </div>

                            <div class="flex items-end">
                                <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                    Filter
                                </button>
                            </div>
                        </div>
                    </form>

                    <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">Peringkat 5 Siswa Teratas</h3>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg mb-8">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Peringkat</th>
                                    <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3">Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-right">
                                        Total {{ $rankingBy == 'jumlah' ? 'Sampah (Pcs)' : 'Nominal (Rp)' }}
                                    </th>
                                    <th scope="col" class="px-6 py-3">Rincian</th>
                                </tr>
                            </thead>
                            
                            {{-- 
                              PERBAIKAN DI SINI: 
                              @forelse dipindah untuk membungkus <tbody>
                              dan x-data diletakkan di <tbody>
                            --}}
                            @forelse ($topSiswa as $index => $item)
                                <tbody x-data="{ open: false }" class="border-b dark:border-gray-700">
                                    <tr class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            #{{ $index + 1 }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->pengguna->nama_lengkap ?? 'Siswa Tidak Ditemukan' }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->kelas->nama_kelas ?? 'N/A' }}
                                        </td>
                                        <td class="px-6 py-4 text-right font-bold">
                                            @if ($rankingBy == 'jumlah')
                                                {{ number_format($item->setoran_sum_jumlah, 0, ',', '.') }} Pcs
                                            @else
                                                Rp {{ number_format($item->setoran_sum_total_harga, 0, ',', '.') }}
                                            @endif
                                        </td>
                                        <td class="px-6 py-4">
                                            <button @click="open = !open" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">
                                                <span x-show="!open">Lihat</span>
                                                <span x-show="open">Tutup</span>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr x-show="open" class="bg-gray-50 dark:bg-gray-900/50">
                                        <td colspan="5" class="px-6 py-4">
                                            <h4 class="font-semibold text-sm mb-2">Rincian Setoran Sampah:</h4>
                                            <ul class="list-disc pl-5 text-xs space-y-1">
                                                @forelse($item->sampahDetails as $detail)
                                                    <li>
                                                        {{ $detail->nama_sampah }}:
                                                        <span class="font-medium">{{ number_format($detail->total_jumlah, 0, ',', '.') }} {{ $detail->satuan }}</span>
                                                    </li>
                                                @empty
                                                    <li class="italic">Tidak ada rincian setoran.</li>
                                                @endforelse
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            @empty
                                <tbody>
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center">
                                            Tidak ada data setoran siswa untuk rentang tanggal yang dipilih.
                                        </td>
                                    </tr>
                                </tbody>
                            @endforelse
                        </table>
                    </div>

                    <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">Peringkat 5 Kelas Teratas</h3>
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Peringkat</th>
                                    <th scope="col" class="px-6 py-3">Nama Kelas</th>
                                    <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-right">
                                        Total {{ $rankingBy == 'jumlah' ? 'Sampah (Kg)' : 'Nominal (Rp)' }}
                                    </th>
                                    <th scope="col" class="px-6 py-3">Rincian</th>
                                </tr>
                            </thead>

                            {{-- PERBAIKAN DI SINI JUGA --}}
                            @forelse ($topKelas as $index => $item)
                                <tbody x-data="{ open: false }" class="border-b dark:border-gray-700">
                                    <tr class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            #{{ $index + 1 }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->nama_kelas }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $item->waliKelas->nama_lengkap ?? 'Belum Diatur' }}
                                        </td>
                                        <td class="px-6 py-4 text-right font-bold">
                                            @if ($rankingBy == 'jumlah')
                                                {{ number_format($item->total_agregat, 0, ',', '.') }} Pcs
                                            @else
                                                Rp {{ number_format($item->total_agregat, 0, ',', '.') }}
                                            @endif
                                        </td>
                                        <td class="px-6 py-4">
                                            <button @click="open = !open" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">
                                                <span x-show="!open">Lihat</span>
                                                <span x-show="open">Tutup</span>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr x-show="open" class="bg-gray-50 dark:bg-gray-900/50">
                                        <td colspan="5" class="px-6 py-4">
                                            <h4 class="font-semibold text-sm mb-2">Rincian Setoran Sampah Kelas:</h4>
                                            <ul class="list-disc pl-5 text-xs space-y-1">
                                                @forelse($item->sampahDetails as $detail)
                                                    <li>
                                                        {{ $detail->nama_sampah }}:
                                                        <span class="font-medium">{{ number_format($detail->total_jumlah, 0, ',', '.') }} {{ $detail->satuan }}</span>
                                                    </li>
                                                @empty
                                                    <li class="italic">Tidak ada rincian setoran.</li>
                                                @endforelse
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            @empty
                                <tbody>
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center">
                                            Tidak ada data setoran kelas untuk rentang tanggal yang dipilih.
                                        </td>
                                    </tr>
                                </tbody>
                            @endforelse
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>