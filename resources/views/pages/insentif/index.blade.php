<x-app-layout>
    <x-slot name="header">
        <div class="flex items-center justify-between">
            <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
                {{ __('Riwayat Insentif Wali Kelas') }}
            </h2>
           
        </div>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-6 text-lg font-semibold">Daftar Riwayat Insentif</h3>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal Insentif</th>
                                    <th scope="col" class="px-6 py-3">Asal Setoran (Siswa)</th>
                                    <th scope="col" class="px-6 py-3">Penerima (Kelas)</th>
                                    <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                    <th scope="col" class="px-6 py-3">Total Setoran</th>
                                    <th scope="col" class="px-6 py-3">Jumlah Insentif</th>
                                    <th scope="col" class="px-6 py-3">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifs as $insentif)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    {{-- Menampilkan tanggal pembuatan record insentif --}}
                                    <td class="px-6 py-4">{{ $insentif->created_at->format('d M Y, H:i') }}</td>
                                    {{-- Menampilkan nama siswa dari relasi setoran --}}
                                    <td class="px-6 py-4">{{ $insentif->setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                                    {{-- Menampilkan nama kelas --}}
                                    <td class="px-6 py-4">{{ $insentif->kelas->nama_kelas ?? 'Kelas Dihapus' }}</td>
                                    {{-- Menampilkan nama wali kelas --}}
                                    <td class="px-6 py-4">{{ $insentif->kelas->waliKelas->nama_lengkap ?? 'Belum Diatur' }}</td>
                                    {{-- Menampilkan total harga dari setoran terkait --}}
                                    <td class="px-6 py-4">Rp {{ number_format($insentif->setoran->total_harga, 0, ',', '.') }}</td>
                                    {{-- Menampilkan jumlah insentif --}}
                                    <td class="px-6 py-4 font-medium text-green-600">Rp {{ number_format($insentif->jumlah_insentif, 0, ',', '.') }}</td>
                                    {{-- Menampilkan status pembayaran dengan badge warna --}}
                                    <td class="px-6 py-4">
                                        @if($insentif->status_pembayaran == 'sudah dibayar')
                                            <span class="px-2 py-1 text-xs font-semibold text-green-800 bg-green-200 rounded-full">
                                                Sudah Dibayar
                                            </span>
                                        @else
                                            <span class="px-2 py-1 text-xs font-semibold text-yellow-800 bg-yellow-200 rounded-full">
                                                Belum Dibayar
                                            </span>
                                        @endif
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    {{-- Sesuaikan colspan dengan jumlah kolom baru (7) --}}
                                    <td colspan="7" class="px-6 py-4 text-center">Belum ada data insentif.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    {{-- Link Paginasi --}}
                    <div class="mt-4">
                        {{ $insentifs->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>