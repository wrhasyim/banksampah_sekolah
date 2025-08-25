<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Laporan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <div class="mb-4 border-b border-gray-200">
                        <ul class="flex flex-wrap -mb-px text-sm font-medium text-center">
                            <li class="me-2">
                                <a href="{{ route('laporan.index', ['tipe' => 'transaksi']) }}" class="inline-block p-4 border-b-2 rounded-t-lg {{ $tipeLaporan == 'transaksi' ? 'border-indigo-500 text-indigo-600' : 'border-transparent hover:text-gray-600 hover:border-gray-300' }}">
                                    Transaksi Siswa
                                </a>
                            </li>
                            <li class="me-2">
                                <a href="{{ route('laporan.index', ['tipe' => 'penjualan']) }}" class="inline-block p-4 border-b-2 rounded-t-lg {{ $tipeLaporan == 'penjualan' ? 'border-indigo-500 text-indigo-600' : 'border-transparent hover:text-gray-600 hover:border-gray-300' }}">
                                    Penjualan
                                </a>
                            </li>
                            <li class="me-2">
                                <a href="{{ route('laporan.index', ['tipe' => 'laba_rugi']) }}" class="inline-block p-4 border-b-2 rounded-t-lg {{ $tipeLaporan == 'laba_rugi' ? 'border-indigo-500 text-indigo-600' : 'border-transparent hover:text-gray-600 hover:border-gray-300' }}">
                                    Laba Rugi
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="{{ route('laporan.filter') }}" method="POST" class="mb-8">
                        @csrf
                        <input type="hidden" name="tipe" value="{{ $tipeLaporan }}">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                            <div>
                                <label for="start_date">Tanggal Mulai</label>
                                <input type="date" name="start_date" id="start_date" class="mt-1 block w-full border-gray-300 rounded-md" value="{{ request('start_date') }}">
                            </div>
                            <div>
                                <label for="end_date">Tanggal Selesai</label>
                                <input type="date" name="end_date" id="end_date" class="mt-1 block w-full border-gray-300 rounded-md" value="{{ request('end_date') }}">
                            </div>
                            @if($tipeLaporan == 'transaksi')
                            <div>
                                <label for="id_kelas">Kelas</label>
                                <select name="id_kelas" id="id_kelas" class="mt-1 block w-full border-gray-300 rounded-md">
                                    <option value="">Semua Kelas</option>
                                    @foreach($kelas as $item)
                                        <option value="{{ $item->id }}" {{ request('id_kelas') == $item->id ? 'selected' : '' }}>{{ $item->nama_kelas }}</option>
                                    @endforeach
                                </select>
                            </div>
                            @endif
                            <div class="flex items-end">
                                <button type="submit" class="px-4 py-2 bg-gray-800 text-white rounded-md">Tampilkan</button>
                            </div>
                        </div>
                    </form>

                    @if(in_array($tipeLaporan, ['transaksi', 'penjualan']) && $results->isNotEmpty())
                        {{-- ... (kode tombol export tidak berubah) ... --}}
                    @endif

                    @if($tipeLaporan == 'transaksi')
                        @include('pages.laporan.partials.tabel-transaksi')
                    @elseif($tipeLaporan == 'penjualan')
                        @include('pages.laporan.partials.tabel-penjualan')
                    @elseif($tipeLaporan == 'laba_rugi')
                        @include('pages.laporan.partials.laporan-laba-rugi')
                    @endif
                </div>
            </div>
        </div>
    </div>
</x-app-layout>