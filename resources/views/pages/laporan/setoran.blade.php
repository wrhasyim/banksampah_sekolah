<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Laporan Setoran Sampah') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form method="post" action="{{ route('laporan.setoran.index') }}" class="space-y-6">
                        @csrf
                        <div class="flex items-center space-x-4">
                            <div>
                                <x-input-label for="start_date" value="Tanggal Mulai" />
                                <x-text-input id="start_date" name="start_date" type="date" class="mt-1 block w-full" :value="old('start_date')" />
                            </div>
                            <div>
                                <x-input-label for="end_date" value="Tanggal Selesai" />
                                <x-text-input id="end_date" name="end_date" type="date" class="mt-1 block w-full" :value="old('end_date')" />
                            </div>
                            <div>
                                <x-input-label for="id_kelas" value="Filter Kelas" />
                                <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm">
                                    <option value="">Semua Kelas</option>
                                    @foreach ($kelas as $k)
                                        <option value="{{ $k->id }}">{{ $k->nama_kelas }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="flex items-end h-full pt-6">
                                <x-primary-button>
                                    {{ __('Tampilkan') }}
                                </x-primary-button>
                            </div>
                        </div>
                    </form>

                    @if ($setoran->isNotEmpty())
                        <div class="mt-6 flex justify-end">
                            <form method="post" action="{{ route('laporan.setoran.export') }}">
                                @csrf
                                <input type="hidden" name="start_date" value="{{ request('start_date') }}">
                                <input type="hidden" name="end_date" value="{{ request('end_date') }}">
                                <input type="hidden" name="id_kelas" value="{{ request('id_kelas') }}">
                                <x-primary-button>
                                    {{ __('Ekspor ke Excel') }}
                                </x-primary-button>
                            </form>
                        </div>
                        
                        <div class="mt-6 relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">Tanggal</th>
                                        <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                        <th scope="col" class="px-6 py-3">Kelas</th>
                                        <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                        <th scope="col" class="px-6 py-3">Jumlah</th>
                                        <th scope="col" class="px-6 py-3">Total Harga</th>
                                        <th scope="col" class="px-6 py-3">Admin</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($setoran as $item)
                                    <tr class="bg-white border-b">
                                        <td class="px-6 py-4">{{ $item->created_at->format('d-m-Y H:i') }}</td>
                                        <td class="px-6 py-4">{{ $item->siswa->pengguna->nama_lengkap }}</td>
                                        <td class="px-6 py-4">{{ $item->siswa->kelas->nama_kelas }}</td>
                                        <td class="px-6 py-4">{{ $item->jenis_sampah->nama_sampah }}</td>
                                        <td class="px-6 py-4">{{ $item->jumlah_satuan }}</td>
                                        <td class="px-6 py-4">Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                                        <td class="px-6 py-4">{{ $item->admin->nama_lengkap }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <div class="mt-6 text-center text-gray-500">
                            Tidak ada data laporan yang tersedia.
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</x-app-layout>