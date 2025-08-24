<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Histori Penarikan Saldo') }}
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

                    <div class="flex items-center space-x-4 mb-4">
                        <a href="{{ route('penarikan.create') }}" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150 mb-4">
                            + Catat Penarikan (Individu)
                        </a>
                        <a href="{{ route('penarikan.createKelas') }}" class="inline-flex items-center px-4 py-2 bg-indigo-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150 mb-4">
                            + Tarik Saldo (Per Kelas)
                        </a>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Tanggal</th>
                                    <th scope="col" class="px-6 py-3">Keterangan</th>
                                    <th scope="col" class="px-6 py-3">Jumlah Penarikan</th>
                                    <th scope="col" class="px-6 py-3">Admin</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($penarikan as $item)
                                <tr class="bg-white border-b hover:bg-gray-50">
                                    <td class="px-6 py-4">{{ $item->created_at->format('d-m-Y H:i') }}</td>
                                    
                                    <td class="px-6 py-4 font-medium text-gray-900">
                                        @if($item->id_kelas)
                                            <span class="font-bold">Penarikan Saldo Kelas: {{ $item->kelas?->nama_kelas ?? 'Kelas Dihapus' }}</span>
                                        @else
                                            {{ $item->siswa?->pengguna?->nama_lengkap ?? 'Siswa Dihapus' }}
                                        @endif
                                    </td>
                                    <td class="px-6 py-4">
                                        Rp {{ number_format($item->jumlah_penarikan, 0, ',', '.') }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $item->admin?->nama_lengkap ?? 'Admin Dihapus' }}
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-4 text-center">Belum ada histori penarikan.</td>
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