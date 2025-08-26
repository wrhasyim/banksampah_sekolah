<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Papan Peringkat') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">
                        Peringkat 10 Siswa Teratas Berdasarkan Total Setoran
                    </h3>
                    
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-center">Peringkat</th>
                                    <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3">Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-right">Total Setoran (Rp)</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($leaderboard as $index => $siswa)
                                <tr class="bg-white border-b hover:bg-gray-50">
                                    <td class="px-6 py-4 font-medium text-gray-900 text-center">
                                        {{ $index + 1 }}
                                    </td>
                                    <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                                        {{ $siswa->nama }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $siswa->nama_kelas }}
                                    </td>
                                    <td class="px-6 py-4 text-right font-semibold text-green-600">
                                        {{ number_format($siswa->total_setoran, 0, ',', '.') }}
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-4 text-center">
                                        Belum ada data setoran untuk ditampilkan.
                                    </td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>