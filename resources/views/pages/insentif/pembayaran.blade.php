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

                    <form action="{{ route('insentif.bayar') }}" method="POST">
                        @csrf
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">Kelas</th>
                                        <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                        <th scope="col" class="px-6 py-3">Total Insentif</th>
                                        <th scope="col" class="px-6 py-3">Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($insentifPerKelas as $item)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="px-6 py-4">{{ $item->kelas->nama_kelas ?? 'Kelas Dihapus' }}</td>
                                        <td class="px-6 py-4">{{ $item->kelas->waliKelas->nama_lengkap ?? 'Belum Diatur' }}</td>
                                        <td class="px-6 py-4 font-medium text-green-600">Rp {{ number_format($item->total_insentif, 0, ',', '.') }}</td>
                                        <td class="px-6 py-4">
                                            {{-- Hidden inputs to send data --}}
                                            <input type="hidden" name="pembayaran[{{ $loop->index }}][kelas_id]" value="{{ $item->kelas_id }}">
                                            <input type="hidden" name="pembayaran[{{ $loop->index }}][jumlah]" value="{{ $item->total_insentif }}">
                                            <button type="submit" name="bayar_single" value="{{ $item->kelas_id }}" class="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700">
                                                Bayar
                                            </button>
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
                        {{-- Optional: Add a "Pay All" button here --}}
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>