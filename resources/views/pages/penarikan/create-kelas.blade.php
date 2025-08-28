<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Tarik SaldoSiswa per Kelas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <div class="mb-4">
                        <p class="text-gray-600 dark:text-gray-400">
                            Fitur ini akan menarik **seluruh sisa saldo** untuk semua siswa dalam satu kelas yang Anda pilih. Aksi ini tidak dapat dibatalkan.
                        </p>
                    </div>

                    <div class="flex justify-start mb-6">
                        <a href="{{ route('penarikan.index') }}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-500 border border-transparent rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
                            Kembali
                        </a>
                    </div>
                    
                    <form action="{{ route('penarikan.store.kelas') }}" method="POST">
                        @csrf
                        <div class="grid grid-cols-1 gap-6">
                            <div>
                                <label for="id_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Kelas</label>
                                <select id="id_kelas" name="id_kelas" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                    <option value="" disabled selected>Pilih kelas yang akan dikosongkan saldonya</option>
                                    @foreach($kelas as $item)
                                        <option value="{{ $item->id }}">{{ $item->nama }}</option>
                                    @endforeach
                                </select>
                                @error('id_kelas')
                                    <p class="mt-2 text-sm text-red-600 dark:text-red-500">{{ $message }}</p>
                                @enderror
                            </div>
                        </div>

                        <div class="flex justify-end mt-6">
                            <button type="submit" class="px-4 py-2 text-sm font-medium text-white bg-red-700 rounded-lg hover:bg-red-800 focus:ring-4 focus:ring-red-300 dark:bg-red-600 dark:hover:bg-red-700 focus:outline-none dark:focus:ring-red-800" onclick="return confirm('Apakah Anda yakin ingin mengosongkan saldo seluruh siswa di kelas ini?')">
                                Kosongkan Saldo Kelas
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>