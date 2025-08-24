<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Laporan Setoran') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium mb-4">Filter Laporan</h3>

                    <form action="{{ route('laporan.setoran.filter') }}" method="POST" class="mb-8">
                        @csrf
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                            <div>
                                <label for="start_date" class="block text-sm font-medium text-gray-700">Tanggal Mulai</label>
                                <input type="date" name="start_date" id="start_date" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" value="{{ request('start_date') }}">
                            </div>
                            <div>
                                <label for="end_date" class="block text-sm font-medium text-gray-700">Tanggal Selesai</label>
                                <input type="date" name="end_date" id="end_date" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" value="{{ request('end_date') }}">
                            </div>
                            <div>
                                <label for="id_kelas" class="block text-sm font-medium text-gray-700">Kelas</label>
                                <select name="id_kelas" id="id_kelas" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                                    <option value="">Semua Kelas</option>
                                    @foreach($kelas as $item)
                                        <option value="{{ $item->id }}" {{ request('id_kelas') == $item->id ? 'selected' : '' }}>{{ $item->nama_kelas }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="flex items-end">
                                <button type="submit" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest">
                                    Tampilkan Laporan
                                </button>
                            </div>
                        </div>
                    </form>

                    @if($setoran->isNotEmpty())
                        <form action="{{ route('laporan.setoran.export') }}" method="POST" class="mb-4">
                            @csrf
                            <input type="hidden" name="start_date" value="{{ request('start_date') }}">
                            <input type="hidden" name="end_date" value="{{ request('end_date') }}">
                            <input type="hidden" name="id_kelas" value="{{ request('id_kelas') }}">
                            <button type="submit" class="inline-flex items-center px-4 py-2 bg-green-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest">
                                Export ke Excel
                            </button>
                        </form>
                    @endif

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3">Tanggal</th>
                                    <th class="px-6 py-3">Nama Siswa</th>
                                    <th class="px-6 py-3">Kelas</th>
                                    <th class="px-6 py-3">Jenis Sampah</th>
                                    <th class="px-6 py-3">Jumlah</th>
                                    <th class="px-6 py-3">Total Harga</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($setoran as $item)
                                <tr class="bg-white border-b">
                                    <td class="px-6 py-4">{{ $item->created_at->format('d M Y') }}</td>
                                    <td class="px-6 py-4">{{ $item->siswa?->pengguna?->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                                    <td class="px-6 py-4">{{ $item->siswa?->kelas?->nama_kelas ?? '-' }}</td>
                                    <td class="px-6 py-4">{{ $item->jenisSampah?->nama_sampah ?? 'Jenis Sampah Dihapus' }}</td>
                                    <td class="px-6 py-4">{{ $item->jumlah_satuan }}</td>
                                    <td class="px-6 py-4">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="6" class="px-6 py-4 text-center">
                                        Tidak ada data untuk ditampilkan. Silakan filter terlebih dahulu.
                                    </td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>