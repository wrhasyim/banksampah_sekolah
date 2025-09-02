<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Pembayaran Insentif Wali Kelas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h3 class="mb-6 text-lg font-semibold">Rekap Insentif Belum Dibayar</h3>

                    {{-- Form dimulai di sini --}}
                    <form action="{{ route('insentif.bayar') }}" method="POST">
                        @csrf
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">Kelas</th>
                                        <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                        <th scope="col" class="px-6 py-3">Total Insentif</th>
                                        {{-- =================== PERUBAHAN 1: Ganti Aksi menjadi "Pilih" =================== --}}
                                        <th scope="col" class="px-6 py-3 text-center">Pilih untuk Dibayar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($insentifPerKelas as $item)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <td class="px-6 py-4">{{ $item->kelas->nama_kelas ?? 'Kelas Dihapus' }}</td>
                                        <td class="px-6 py-4">{{ $item->kelas->waliKelas->nama_lengkap ?? 'Belum Diatur' }}</td>
                                        <td class="px-6 py-4 font-medium text-green-600">Rp {{ number_format($item->total_insentif, 0, ',', '.') }}</td>
                                        
                                        {{-- =================== PERUBAHAN 2: Ganti Tombol menjadi Checkbox =================== --}}
                                        <td class="px-6 py-4 text-center">
                                            {{-- Checkbox ini akan mengirim data hanya jika dicentang --}}
                                            <input type="checkbox" name="pembayaran[{{ $item->kelas_id }}][status]" value="bayar" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                            
                                            {{-- Data ini akan ikut terkirim HANYA jika checkbox di atas dicentang --}}
                                            <input type="hidden" name="pembayaran[{{ $item->kelas_id }}][jumlah]" value="{{ $item->total_insentif }}">
                                            <input type="hidden" name="pembayaran[{{ $item->kelas_id }}][kelas_id]" value="{{ $item->kelas_id }}">
                                        </td>
                                    </tr>
                                    @empty
                                    <tr>
                                        <td colspan="4" class="px-6 py-4 text-center">Tidak ada insentif yang perlu dibayar saat ini.</td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        {{-- =================== PERUBAHAN 3: Tambahkan satu tombol submit di luar tabel =================== --}}
                        <div class="flex justify-end mt-6">
                            @if($insentifPerKelas->isNotEmpty())
                                <x-primary-button>
                                    {{ __('Bayar Insentif yang Dipilih') }}
                                </x-primary-button>
                            @endif
                        </div>
                    </form>
                    {{-- Form berakhir di sini --}}

                </div>
            </div>
        </div>
    </div>
</x-app-layout>