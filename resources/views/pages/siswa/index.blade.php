<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Kelola Data Siswa') }}
        </h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if (session('status'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('status') }}</span>
                        </div>
                    @endif

                    <div class="flex justify-between items-center mb-4">
                        <div class="flex space-x-2">
                            <a href="{{ route('siswa.create') }}" class="px-4 py-2 bg-gray-800 text-white rounded-md text-xs uppercase font-semibold">Tambah Siswa</a>
                            <a href="{{ route('siswa.import.form') }}" class="px-4 py-2 bg-yellow-500 text-white rounded-md text-xs uppercase font-semibold">Impor Siswa</a>
                            <form action="{{ route('siswa.export') }}" method="POST">
                                @csrf
                                <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-md text-xs uppercase font-semibold">Ekspor Siswa</button>
                            </form>
                        </div>
                        
                        <div class="flex items-center space-x-2 text-sm">
                            <form action="{{ route('siswa.index') }}" method="GET">
                                <label for="per_page">Tampilkan:</label>
                                <select name="per_page" id="per_page" onchange="this.form.submit()" class="border-gray-300 rounded-md shadow-sm text-sm">
                                    <option value="10" {{ $perPage == 10 ? 'selected' : '' }}>10</option>
                                    <option value="20" {{ $perPage == 20 ? 'selected' : '' }}>20</option>
                                    <option value="50" {{ $perPage == 50 ? 'selected' : '' }}>50</option>
                                    <option value="100" {{ $perPage == 100 ? 'selected' : '' }}>100</option>
                                </select>
                            </form>
                        </div>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left rtl:text-right text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3">No</th>
                                    <th scope="col" class="px-6 py-3">Nama Lengkap</th>
                                    <th scope="col" class="px-6 py-3">Username</th>
                                    <th scope="col" class="px-6 py-3">NIS</th>
                                    <th scope="col" class="px-6 py-3">Kelas</th>
                                    <th scope="col" class="px-6 py-3">Saldo</th>
                                    <th scope="col" class="px-6 py-3">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($siswa as $item)
                                <tr class="bg-white border-b hover:bg-gray-50">
                                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">{{ $loop->iteration + ($siswa->currentPage() - 1) * $siswa->perPage() }}</th>
                                    <td class="px-6 py-4">{{ $item->pengguna->nama_lengkap }}</td>
                                    <td class="px-6 py-4">{{ $item->pengguna->username }}</td>
                                    <td class="px-6 py-4">{{ $item->nis ?? '-' }}</td>
                                    <td class="px-6 py-4">{{ $item->kelas->nama_kelas }}</td>
                                    <td class="px-6 py-4 font-bold">Rp {{ number_format($item->saldo, 0, ',', '.') }}</td>
                                    <td class="px-6 py-4 flex items-center">
                                        <a href="{{ route('siswa.edit', $item->id) }}" class="font-medium text-blue-600 hover:underline">Edit</a>
                                        <form action="{{ route('siswa.destroy', $item->id) }}" method="POST" class="inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="font-medium text-red-600 hover:underline ml-4" onclick="return confirm('Anda yakin ingin menghapus data ini?')">
                                                Hapus
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="7" class="px-6 py-4 text-center text-gray-500">Data siswa masih kosong.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-4">
                        {{ $siswa->appends(['per_page' => $perPage])->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>