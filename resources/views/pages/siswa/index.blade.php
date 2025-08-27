<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Data Siswa') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <div class="flex flex-col items-start justify-between gap-4 mb-6 md:flex-row md:items-center">
                        <div class="flex items-center space-x-2">
                            <a href="{{ route('siswa.create') }}"
                                class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-blue-700 border border-transparent rounded-md hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Tambah Siswa
                            </a>
                            <a href="{{ route('siswa.import.form') }}"
                                class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 border border-transparent rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500">
                                Impor
                            </a>
                        </div>
                        <div class="flex items-center space-x-2">
                            <a href="{{ route('siswa.export') }}"
                                class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-green-600 border border-transparent rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                Ekspor
                            </a>
                        </div>
                    </div>
                    
                    {{-- PERBAIKAN: Form untuk paginasi --}}
                    <form method="GET" action="{{ route('siswa.index') }}" class="flex items-center mb-4">
                        <label for="perPage" class="mr-2 text-sm text-gray-600 dark:text-gray-400">Tampilkan:</label>
                        <select name="perPage" id="perPage" onchange="this.form.submit()" class="block w-24 text-sm border-gray-300 rounded-md shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600 dark:text-gray-300">
                            <option value="10" {{ $perPage == 10 ? 'selected' : '' }}>10</option>
                            <option value="25" {{ $perPage == 25 ? 'selected' : '' }}>25</option>
                            <option value="50" {{ $perPage == 50 ? 'selected' : '' }}>50</option>
                            <option value="100" {{ $perPage == 100 ? 'selected' : '' }}>100</option>
                        </select>
                        <span class="ml-2 text-sm text-gray-600 dark:text-gray-400">data per halaman</span>
                    </form>

                    <div class="overflow-x-auto">
                        <table class="min-w-full bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-700">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">No</th>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Nama</th>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">NIS</th>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Saldo</th>
                                    <th scope="col" class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">Aksi</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                                @forelse ($siswa as $item)
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $loop->iteration + ($siswa->currentPage() - 1) * $siswa->perPage() }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $item->pengguna->name }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $item->nis }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">{{ $item->kelas->nama }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">Rp. {{ number_format($item->saldo) }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <a href="{{ route('siswa.edit', $item->id) }}" class="text-indigo-600 hover:text-indigo-900">Edit</a>
                                            <form action="{{ route('siswa.destroy', $item->id) }}" method="POST" class="inline">
                                                @csrf
                                                @method('delete')
                                                <button type="submit" class="ml-2 text-red-600 hover:text-red-900" onclick="return confirm('Apakah anda yakin ingin menghapus data ini?')">Hapus</button>
                                            </form>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="px-6 py-4 text-center whitespace-nowrap">Tidak ada data</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    
                    {{-- PERBAIKAN: Menampilkan link paginasi --}}
                    <div class="mt-6">
                        {{ $siswa->appends(['perPage' => $perPage])->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>