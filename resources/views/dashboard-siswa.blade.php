<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            {{-- Pesan Selamat Datang --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                <div class="p-6 text-gray-900">
                    <p class="text-lg font-medium">{{ __("Selamat datang, ") }} <strong>{{ Auth::user()->nama_lengkap }}!</strong></p>
                    <p class="text-sm text-gray-600">{{ __("Kelas: ") }} <strong class="text-indigo-600">{{ $siswa->kelas->nama_kelas ?? 'Belum ada kelas' }}</strong></p>
                </div>
            </div>

            {{-- ================================================== --}}
            {{-- STATISTIK UTAMA SISWA (IKON DIPERBARUI) --}}
            {{-- ================================================== --}}
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 flex items-center space-x-4">
                        <div class="flex-shrink-0 flex items-center justify-center h-12 w-12 bg-green-100 p-3 rounded-full text-green-600">
                            {{-- IKON BARU: Dompet (Lebih Simetris) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M21 12a2.25 2.25 0 00-2.25-2.25H15a3 3 0 11-6 0H5.25A2.25 2.25 0 003 12m18 0v6a2.25 2.25 0 01-2.25 2.25H5.25A2.25 2.25 0 013 18v-6m18 0V9M3 12V9m18 3a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 12m15 0a2.25 2.25 0 012.25 2.25v3.75a2.25 2.25 0 01-2.25 2.25H5.25a2.25 2.25 0 01-2.25-2.25V14.25a2.25 2.25 0 012.25-2.25h.097" />
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-medium text-gray-500 truncate">Total Saldo Anda</h3>
                            <p class="mt-1 text-3xl font-semibold text-green-600">
                                Rp {{ number_format($siswa->saldo, 0, ',', '.') }}
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 flex items-center space-x-4">
                        <div class="flex-shrink-0 flex items-center justify-center h-12 w-12 bg-blue-100 p-3 rounded-full text-blue-600">
                             {{-- IKON BARU: Timbangan (Simetris) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v17.25m0 0c-1.472 0-2.882.265-4.185.75M12 20.25c1.472 0 2.882.265 4.185.75M18.75 4.97A48.416 48.416 0 0012 4.5c-2.291 0-4.545.16-6.75.47m13.5 0c-3.079 0-6.09 1.09-8.625 3.016m8.625-3.016c.336.026.66.06.974.098M5.25 4.97c-.336.026-.66.06-.974.098m14.452 0c-3.079 0-6.09 1.09-8.625 3.016M4.276 8.064c-1.934 2.14-3.11 4.752-3.11 7.69m19.668-7.69c-1.934 2.14-3.11 4.752-3.11 7.69" />
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-medium text-gray-500 truncate">Total Berat Setoran</h3>
                            <p class="mt-1 text-3xl font-semibold text-blue-600">
                                {{ number_format($totalBeratSetoran, 0, ',', '.') }} <span class="text-lg font-normal text-gray-500">Pcs</span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 flex items-center space-x-4">
                        <div class="flex-shrink-0 flex items-center justify-center h-12 w-12 bg-purple-100 p-3 rounded-full text-purple-600">
                            {{-- IKON BARU: Kuitansi/Daftar (Simetris) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-medium text-gray-500 truncate">Frekuensi Setoran</h3>
                            <p class="mt-1 text-3xl font-semibold text-purple-600">
                                {{ $totalFrekuensiSetoran }} <span class="text-lg font-normal text-gray-500">Kali</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            {{-- ================================================== --}}
            {{-- AKHIR PERUBAHAN IKON --}}
            {{-- ================================================== --}}


            {{-- Riwayat Setoran Terakhir --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Riwayat Setoran</h3>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jenis Sampah</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Jumlah (Pcs)</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total (Rp)</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                @forelse ($setoranTerakhir as $setoran)
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ $setoran->created_at->format('d M Y, H:i') }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ $setoran->jenisSampah->nama_sampah ?? 'Sampah Dihapus' }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">{{ $setoran->jumlah }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-green-600 font-medium text-right">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="4" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">Belum ada riwayat setoran.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    {{-- Link Paginasi --}}
                    <div class="mt-4">
                        {{ $setoranTerakhir->links() }}
                    </div>

                </div>
            </div>

        </div>
    </div>
</x-app-layout>