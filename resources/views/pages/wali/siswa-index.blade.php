<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Daftar Siswa Kelas Anda') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            {{-- Info Kelas --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                <div class="p-6 text-gray-900">
                    <p class="text-lg font-medium">{{ __("Kelas yang Anda Ampu:") }} <strong>{{ $kelas->nama_kelas }}</strong></p>
                    <p class="text-sm text-gray-600">Total <strong>{{ $siswas->total() }}</strong> siswa di kelas ini.</p>
                </div>
            </div>

            {{-- Form Pencarian --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                <div class="p-6">
                    <form method="GET" action="{{ route('wali.siswa.index') }}">
                        <div class="flex flex-col md:flex-row gap-2">
                            <div class="flex-grow">
                                <x-input-label for="search" :value="__('Cari Siswa (Nama / NIS)')" />
                                <x-text-input id="search" name="search" type="text" class="mt-1 block w-full"
                                               :value="request('search')"
                                               placeholder="Masukkan Nama atau NIS..."/>
                            </div>
                            <div class="self-end">
                                <x-primary-button class="mt-1 py-3">
                                    {{ __('Cari') }}
                                </x-primary-button>
                                <a href="{{ route('wali.siswa.index') }}" class="mt-1 inline-flex items-center px-4 py-2 bg-gray-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-500 active:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition ease-in-out duration-150">
                                    Reset
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            {{-- Tabel Siswa --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">NIS</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nama Siswa</th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Saldo</th>
                                <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            @forelse ($siswas as $siswa)
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $siswa->nis }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ $siswa->pengguna->nama_lengkap ?? '[Nama Hilang]' }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-green-600 font-medium text-right">Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-center">
                                        {{-- Link ini akan mengarah ke Buku Tabungan Siswa (yang sudah ada) --}}
                                        <a href="{{ route('buku-tabungan.show', $siswa->id) }}" class="text-indigo-600 hover:text-indigo-900">
                                            Lihat Buku Tabungan
                                        </a>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">Belum ada data siswa di kelas ini.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                
                {{-- Paginasi --}}
                <div class="p-6 border-t border-gray-200">
                    {{ $siswas->links() }}
                </div>
            </div>

        </div>
    </div>
</x-app-layout>