<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Kelola Jenis Sampah') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                @if (session('status'))
                    <div class="mb-4 bg-green-100 border-green-400 text-green-700 px-4 py-3 rounded">{{ session('status') }}</div>
                @endif
                @if (session('error'))
                    <div class="mb-4 bg-red-100 border-red-400 text-red-700 px-4 py-3 rounded">{{ session('error') }}</div>
                @endif
                <a href="{{ route('jenis-sampah.create') }}" class="inline-flex items-center px-4 py-2 bg-gray-800 text-white rounded-md text-xs uppercase font-semibold mb-4">Tambah Jenis Sampah</a>
                <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                    <table class="w-full text-sm text-left text-gray-500">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                            <tr>
                                <th class="px-6 py-3">No</th>
                                <th class="px-6 py-3">Nama Sampah</th>
                                <th class="px-6 py-3">Harga</th>
                                <th class="px-6 py-3">Stok</th>
                                <th class="px-6 py-3">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($jenisSampah as $item)
                            <tr class="bg-white border-b hover:bg-gray-50">
                                <th class="px-6 py-4">{{ $loop->iteration }}</th>
                                <td class="px-6 py-4">{{ $item->nama_sampah }}</td>
                                <td class="px-6 py-4">Rp {{ number_format($item->harga_per_satuan, 0, ',', '.') }} / {{ $item->satuan }}</td>
                                <td class="px-6 py-4 font-bold">{{ $item->stok }} {{ $item->satuan }}</td>
                                <td class="px-6 py-4 flex items-center">
                                    <a href="{{ route('jenis-sampah.edit', $item->id) }}" class="font-medium text-blue-600 hover:underline">Edit</a>
                                    <form action="{{ route('jenis-sampah.destroy', $item->id) }}" method="POST" class="inline" onsubmit="return confirm('Anda yakin?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="font-medium text-red-600 hover:underline ml-4">Hapus</button>
                                    </form>
                                </td>
                            </tr>
                            @empty
                                <tr><td colspan="5" class="px-6 py-12 text-center">...</td></tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>