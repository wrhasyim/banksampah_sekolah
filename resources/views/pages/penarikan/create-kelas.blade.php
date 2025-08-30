<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Buat Penarikan Baru (Per Kelas)') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <p class="mb-4 text-sm text-gray-600 dark:text-gray-400">Fitur ini akan menarik seluruh saldo dari semua siswa yang ada di kelas yang dipilih. Transaksi ini tidak dapat dibatalkan.</p>

                    <form action="{{ route('penarikan.store.kelas') }}" method="POST">
                        @csrf
                        <div class="mb-4">
                            <label for="id_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Kelas</label>
                            <select id="id_kelas" name="id_kelas" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
                                <option value="" disabled selected>-- Pilih Kelas --</option>
                                @forelse($kelas as $item)
                                    <option value="{{ $item->id }}">
                                        {{ $item->nama_kelas }} (Total Saldo: Rp {{ number_format($item->siswa->sum('saldo'), 0, ',', '.') }})
                                    </option>
                                @empty
                                    <option disabled>Tidak ada kelas dengan saldo yang bisa ditarik.</option>
                                @endforelse
                            </select>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                             <a href="{{ route('penarikan.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">Batal</a>
                            <button type="submit" class="px-4 py-2 text-white bg-red-600 rounded-md hover:bg-red-700" onclick="return confirm('Anda yakin ingin menarik seluruh saldo dari kelas ini?')">Tarik Semua Saldo Kelas</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>