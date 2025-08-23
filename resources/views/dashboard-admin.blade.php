<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard Admin') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Siswa</h3>
                    <p class="mt-2 text-3xl font-bold">{{ $totalSiswa }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Total Saldo Terkumpul</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSaldo, 0, ',', '.') }}</p>
                </div>
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 text-center">
                    <h3 class="text-lg font-medium text-gray-900">Setoran Hari Ini</h3>
                    <p class="mt-2 text-3xl font-bold">Rp {{ number_format($totalSetoranHariIni, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">🏆 Peringkat Siswa Teraktif</h3>
                    <ol class="list-decimal list-inside">
                        @forelse ($peringkatSiswa as $siswa)
                            <li class="mb-2">
                                <span class="font-semibold">{{ $siswa->pengguna->nama_lengkap }}</span>
                                <span class="text-gray-600 text-sm float-right">{{ $siswa->total_satuan }} pcs</span>
                            </li>
                        @empty
                            <p class="text-gray-500">Belum ada data setoran.</p>
                        @endforelse
                    </ol>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">🏆 Peringkat Kelas Teraktif</h3>
                    <ol class="list-decimal list-inside">
                        @forelse ($peringkatKelas as $kelas)
                            <li class="mb-2">
                                <span class="font-semibold">{{ $kelas->nama_kelas }}</span>
                                <span class="text-gray-600 text-sm float-right">{{ $kelas->total_satuan }} pcs</span>
                            </li>
                        @empty
                            <p class="text-gray-500">Belum ada data setoran.</p>
                        @endforelse
                    </ol>
                </div>
            </div>

        </div>
    </div>
</x-app-layout>