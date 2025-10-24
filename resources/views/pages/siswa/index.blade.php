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

                    {{-- Tombol Impor & Ekspor Lama (Tidak Diubah) --}}
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            
                            <a href="{{ route('siswa.import.form') }}" class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 ml-2 dark:bg-green-600 dark:hover:bg-green-700 focus:outline-none dark:focus:ring-green-800">
                                {{ __('Impor Siswa') }}
                            </a>
                        </div>
                        <div>
                            <a href="{{ route('siswa.export') }}" class="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-gray-600 dark:hover:bg-gray-700 focus:outline-none dark:focus:ring-gray-800">
                                {{ __('Ekspor Data') }}
                            </a>
                        </div>
                    </div>

                    {{-- ====================================================== --}}
                    {{-- BLOK BARU: Filter Lanjutan dan Tombol Export --}}
                    {{-- ====================================================== --}}
                    <div class="mb-6 p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg border dark:border-gray-700">
                        <form action="{{ route('siswa.index') }}" method="GET">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                
                                {{-- Filter Kelas (dari kode asli, digabungkan) --}}
                                <div>
                                    <label for="id_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Filter Kelas</label>
                                    <select name="id_kelas" id="id_kelas" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                        <option value="">-- Semua Kelas --</option>
                                        @foreach($kelas as $k)
                                            <option value="{{ $k->id }}" {{ request('id_kelas') == $k->id ? 'selected' : '' }}>
                                                {{ $k->nama_kelas }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>

                                {{-- Filter Tidak Aktif (Baru) --}}
                                <div>
                                    <label for="filter_tidak_aktif" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Filter Siswa Tidak Aktif</label>
                                    <select name="filter_tidak_aktif" id="filter_tidak_aktif" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                        <option value="">-- Semua Siswa --</option>
                                        <option value="1w" {{ request('filter_tidak_aktif') == '1w' ? 'selected' : '' }}>Tidak Setor > 1 Minggu</option>
                                        <option value="1m" {{ request('filter_tidak_aktif') == '1m' ? 'selected' : '' }}>Tidak Setor > 1 Bulan</option>
                                        <option value="2m" {{ request('filter_tidak_aktif') == '2m' ? 'selected' : '' }}>Tidak Setor > 2 Bulan</option>
                                    </select>
                                </div>
                                
                                {{-- Tombol Filter (Baru) --}}
                                <div class="flex items-end space-x-2">
                                    <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                        Filter
                                    </button>
                                    <a href="{{ route('siswa.index') }}" class="text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700">
                                        Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                        
                        {{-- Tombol Export (Baru) --}}
                        <div class="mt-4 pt-4 border-t dark:border-gray-600 flex items-center space-x-3">
                            <span class="text-sm font-medium text-gray-900 dark:text-white">Export Hasil Filter:</span>
                            {{-- Tombol ini meneruskan query string filter (id_kelas & filter_tidak_aktif) ke route export --}}
                            <a href="{{ route('siswa.exportXlsx', request()->query()) }}" class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-green-600 dark:hover:bg-green-700 focus:outline-none dark:focus:ring-green-800">
                                Export XLSX
                            </a>
                            <a href="{{ route('siswa.exportPdf', request()->query()) }}" class="text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-red-600 dark:hover:bg-red-700 focus:outline-none dark:focus:ring-red-800">
                                Export PDF
                            </a>
                        </div>
                    </div>
                    {{-- ====================================================== --}}
                    {{-- AKHIR BLOK BARU --}}
                    {{-- ====================================================== --}}


                    {{-- Form filter kelas yang lama dihapus, diganti blok di atas --}}
                    {{-- <form action="{{ route('siswa.index') }}" method="GET" class="mb-4"> ... </form> --}}

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Nama Lengkap</th>
                                    <th scope="col" class="px-6 py-3">Username</th>
                                    <th scope="col" class="px-6 py-3">NIS</th>
                                    <th scope="col" class="px-6 py-3">Kelas</th>
                                    <th scope="col" class="px-6 py-3">Saldo</th>
                                    
                                    {{-- KOLOM BARU DITAMBAHKAN --}}
                                    <th scope="col" class="px-6 py-3">Setoran Terakhir</th>

                                    <th scope="col" class="px-6 py-3">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($siswas as $siswa)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ $siswa->pengguna->nama_lengkap }}</td>
                                    <td class="px-6 py-4">{{ $siswa->pengguna->username }}</td>
                                    <td class="px-6 py-4">{{ $siswa->nis }}</td>
                                    <td class="px-6 py-4">{{ $siswa->kelas->nama_kelas }}</td>
                                    <td class="px-6 py-4">Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</td>
                                    
                                    {{-- DATA BARU DITAMBAHKAN --}}
                                    <td class="px-6 py-4">
                                        {{ $siswa->setoranTerakhir ? $siswa->setoranTerakhir->created_at->format('d/m/Y') : 'Belum Pernah' }}
                                    </td>

                                    <td class="px-6 py-4">
                                        <a href="{{ route('siswa.edit', $siswa) }}" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit</a>
                                        <form action="{{ route('siswa.destroy', $siswa) }}" method="POST" onsubmit="return confirm('Apakah Anda yakin ingin menghapus siswa ini beserta seluruh datanya?');" class="inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="ml-2 font-medium text-red-600 dark:text-red-500 hover:underline">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    {{-- Colspan diubah dari 6 menjadi 7 --}}
                                    <td colspan="7" class="px-6 py-4 text-center">Tidak ada data siswa.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{-- Pagination (Sudah benar, tidak diubah) --}}
                        {{ $siswas->appends(request()->query())->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>