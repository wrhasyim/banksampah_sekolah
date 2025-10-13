<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Daftar Insentif Dihasilkan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    @if (session('success'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('success') }}</span>
                        </div>
                    @endif
                    @if (session('error'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('error') }}</span>
                        </div>
                    @endif

                    <div class="mb-6 p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                        <h3 class="font-semibold text-lg text-gray-800 dark:text-gray-200 mb-3">Filter Berdasarkan Tanggal</h3>
                        <form action="{{ route('insentif.index') }}" method="GET">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                                <div>
                                    <label for="start_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
                                    <input type="date" name="start_date" id="start_date" value="{{ $startDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm dark:bg-gray-900 dark:border-gray-600">
                                </div>
                                <div>
                                    <label for="end_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
                                    <input type="date" name="end_date" id="end_date" value="{{ $endDate }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm dark:bg-gray-900 dark:border-gray-600">
                                </div>
                                <div class="flex space-x-2">
                                    <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                        <i class="fas fa-filter mr-2"></i> Terapkan
                                    </button>
                                    <a href="{{ route('insentif.index') }}" class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 dark:bg-gray-600 dark:text-gray-300 dark:hover:bg-gray-500">
                                        Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="mb-6 p-4 bg-red-50 dark:bg-gray-700/50 rounded-lg border border-red-200 dark:border-red-900">
                        <h3 class="font-semibold text-lg text-red-800 dark:text-red-300 mb-3">
                            <i class="fas fa-exclamation-triangle mr-2"></i> Batalkan (Void) Insentif per Kelas
                        </h3>
                        <form action="{{ route('insentif.voidPerKelas') }}" method="POST" onsubmit="return confirm('PERINGATAN: Aksi ini akan menghapus SEMUA insentif untuk kelas dan tanggal yang dipilih. Apakah Anda benar-benar yakin?');">
                            @csrf
                            @method('DELETE')
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                                <div>
                                    <label for="kelas_id" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Pilih Kelas</label>
                                    <select name="kelas_id" id="kelas_id" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm dark:bg-gray-900 dark:border-gray-600">
                                        <option value="">-- Pilih Kelas --</option>
                                        @foreach ($kelas as $k)
                                            <option value="{{ $k->id }}">{{ $k->nama_kelas }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div>
                                    <label for="tanggal" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Pilih Tanggal</label>
                                    <input type="date" name="tanggal" id="tanggal" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm dark:bg-gray-900 dark:border-gray-600">
                                </div>
                                <div>
                                    <button type="submit" class="w-full inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                                        <i class="fas fa-trash-alt mr-2"></i> Void per Kelas
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">No</th>
                                    <th scope="col" class="px-6 py-3">Tanggal Setor</th>
                                    <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                    <th scope="col" class="px-6 py-3">Wali Kelas</th>
                                    <th scope="col" class="px-6 py-3 text-right">Jumlah Insentif (Rp)</th>
                                    <th scope="col" class="px-6 py-3">Status Pembayaran</th>
                                    <th scope="col" class="px-6 py-3 text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($insentifs as $insentif)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="px-6 py-4">{{ $loop->iteration + $insentifs->firstItem() - 1 }}</td>
                                        <td class="px-6 py-4">{{ \Carbon\Carbon::parse($insentif->setoran->created_at)->isoFormat('D MMM Y') }}</td>
                                        <td class="px-6 py-4 font-medium text-gray-900 dark:text-white">
                                            {{ $insentif->setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}
                                        </td>
                                        <td class="px-6 py-4">{{ $insentif->kelas->waliKelas->nama_lengkap ?? 'Tidak Ada' }}</td>
                                        <td class="px-6 py-4 text-right">{{ number_format($insentif->jumlah_insentif, 0, ',', '.') }}</td>
                                        <td class="px-6 py-4">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full {{ $insentif->status_pembayaran == 'sudah dibayar' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800' }}">
                                                {{ $insentif->status_pembayaran }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <form action="{{ route('insentif.destroy', $insentif->id) }}" method="POST" onsubmit="return confirm('Apakah Anda yakin ingin membatalkan (void) insentif ini?');">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="text-red-600 hover:text-red-900 dark:text-red-400 dark:hover:text-red-200">
                                                    <i class="fas fa-trash-alt"></i> Void
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="7" class="px-6 py-4 text-center">Tidak ada data insentif pada periode ini.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        {{ $insentifs->appends(request()->query())->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>