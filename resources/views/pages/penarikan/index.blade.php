<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Riwayat Penarikan Saldo') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    {{-- Header dan Tombol Aksi --}}
                    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
                        <h3 class="text-lg font-semibold">Daftar Penarikan</h3>
                        <div class="flex space-x-2">
                            <a href="{{ route('penarikan.create') }}" class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700">Tarik per Siswa</a>
                            <a href="{{ route('penarikan.create.kelas') }}" class="inline-flex items-center px-4 py-2 bg-purple-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-purple-700">Tarik per Kelas</a>
                        </div>
                    </div>

                    {{-- Form Pencarian dan Filter --}}
                    <form action="{{ route('penarikan.index') }}" method="GET" class="mb-6">
                        <div class="flex flex-col md:flex-row gap-4">
                            <div class="flex-1">
                                <x-input-label for="search" :value="__('Cari Nama Siswa')" />
                                <x-text-input id="search" name="search" type="text" class="block w-full mt-1" value="{{ request('search') }}" placeholder="Masukkan nama..."/>
                            </div>
                            <div class="flex-1">
                                <x-input-label for="status" :value="__('Filter berdasarkan Status')" />
                                <select id="status" name="status" class="block w-full mt-1 border-gray-300 rounded-md shadow-sm dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600">
                                    <option value="">Semua Status</option>
                                    <option value="pending" {{ request('status') == 'pending' ? 'selected' : '' }}>Pending</option>
                                    <option value="disetujui" {{ request('status') == 'disetujui' ? 'selected' : '' }}>Disetujui</option>
                                    <option value="ditolak" {{ request('status') == 'ditolak' ? 'selected' : '' }}>Ditolak</option>
                                </select>
                            </div>
                            <div class="self-end">
                                <x-primary-button type="submit">Filter</x-primary-button>
                            </div>
                        </div>
                    </form>

                    {{-- Tabel Data --}}
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Nama Penarik</th>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Jumlah</th>
                                    <th scope="col" class="px-6 py-3">Status</th>
                                    <th scope="col" class="px-6 py-3">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($penarikans as $penarikan)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-6 py-4">
                                        {{ $penarikan->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ \Carbon\Carbon::parse($penarikan->tanggal_penarikan)->format('d F Y') }}
                                    </td>
                                    <td class="px-6 py-4 font-medium">
                                        Rp. {{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}
                                    </td>
                                    <td class="px-6 py-4">
                                        @php $status = $penarikan->status ?: 'pending'; @endphp
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                            @if($status == 'pending') bg-yellow-100 text-yellow-800 @endif
                                            @if($status == 'disetujui') bg-green-100 text-green-800 @endif
                                            @if($status == 'ditolak') bg-red-100 text-red-800 @endif">
                                            {{ ucfirst($status) }}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        @if ($penarikan->status == 'pending' || is_null($penarikan->status))
                                            <div class="flex items-center space-x-2">
                                                {{-- FORM UNTUK MENYETUJUI --}}
                                                <form action="{{ route('penarikan.update', $penarikan->id) }}" method="POST" onsubmit="return confirm('Anda yakin ingin MENYETUJUI penarikan ini? Saldo siswa akan langsung dipotong.');">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="disetujui">
                                                    <button type="submit" class="text-green-600 hover:text-green-900">Setujui</button>
                                                </form>

                                                {{-- FORM UNTUK MENOLAK --}}
                                                <form action="{{ route('penarikan.update', $penarikan->id) }}" method="POST" onsubmit="return confirm('Anda yakin ingin MENOLAK penarikan ini?');">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="ditolak">
                                                    <button type="submit" class="text-red-600 hover:text-red-900">Tolak</button>
                                                </form>
                                            </div>
                                        @else
                                            <span>-</span>
                                        @endif
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="5" class="px-6 py-4 text-center">Tidak ada data penarikan.</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    {{-- Pagination Links --}}
                    <div class="mt-6">
                        {{ $penarikans->links() }}
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>