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

            {{-- Statistik Utama Siswa (Diperbarui) --}}
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 flex items-center space-x-4">
                        <div class="flex-shrink-0 bg-green-500 p-3 rounded-full text-white">
                            {{-- Ikon Uang (SVG Sederhana) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v.01M12 12v.01M12 12c-1.657 0-3-.895-3-2s1.343-2 3-2m0 8c1.11 0 2.08-.402 2.599-1M12 16v1m0-1v-.01m0-4.01V12m0 4c-1.657 0-3-.895-3-2s1.343-2 3-2m0 8a9 9 0 110-18 9 9 0 010 18z" />
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
                        <div class="flex-shrink-0 bg-blue-500 p-3 rounded-full text-white">
                             {{-- Ikon Timbangan (SVG Sederhana) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 00-1.001 3.771 5 5 0 009.58-1.77c.362-1.428.093-2.926-.7-4.2l-3.879-6M3 6l3-1m0 0l3.879 6c.793 1.274 1.062 2.772.7 4.2-.362 1.428-1.46 2.529-2.89 2.891a5 5 0 00-6.68 4.229 1 1 0 101.98.2 3 3 0 015.01-2.53 3 3 0 01-1.2-5.495L3 6z" />
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
                        <div class="flex-shrink-0 bg-purple-500 p-3 rounded-full text-white">
                            {{-- Ikon Transaksi (SVG Sederhana) --}}
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
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
                                {{-- Loop akan tetap menampilkan 5 data, tapi dari koleksi paginasi --}}
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

                    {{-- ================================================== --}}
                    {{-- TAMBAHAN: LINK PAGINASI --}}
                    {{-- ================================================== --}}
                    <div class="mt-4">
                        {{ $setoranTerakhir->links() }}
                    </div>
                    {{-- ================================================== --}}
                    {{-- AKHIR TAMBAHAN --}}
                    {{-- ================================================== --}}

                </div>
            </div>

        </div>
    </div>
</x-app-layout>