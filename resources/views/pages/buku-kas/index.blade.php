<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Buku Kas') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-1">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium mb-4">Catat Transaksi Baru</h3>
                        <form action="{{ route('buku-kas.store') }}" method="POST">
                            @csrf
                            <div>
                                <x-input-label for="tanggal" value="Tanggal Transaksi" />
                                <x-text-input id="tanggal" class="block mt-1 w-full" type="date" name="tanggal" :value="old('tanggal', date('Y-m-d'))" required />
                            </div>
                            <div class="mt-4">
                                <x-input-label for="deskripsi" value="Deskripsi" />
                                <x-text-input id="deskripsi" class="block mt-1 w-full" type="text" name="deskripsi" :value="old('deskripsi')" required placeholder="Contoh: Beli karung sampah" />
                            </div>
                            <div class="mt-4">
                                <x-input-label for="tipe" value="Tipe Transaksi" />
                                <select name="tipe" id="tipe" class="block mt-1 w-full border-gray-300 rounded-md" required>
                                    <option value="pengeluaran">Pengeluaran</option>
                                    <option value="pemasukan">Pemasukan</option>
                                </select>
                            </div>
                            <div class="mt-4">
                                <x-input-label for="id_kategori" value="Kategori" />
                                <select name="id_kategori" id="id_kategori" class="block mt-1 w-full border-gray-300 rounded-md">
                                    <option value="">-- Pilih Kategori --</option>
                                    @foreach ($kategori as $kat)
                                        <option value="{{ $kat->id }}">{{ $kat->nama_kategori }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="mt-4">
                                <x-input-label for="jumlah" value="Jumlah (Rp)" />
                                <x-text-input id="jumlah" class="block mt-1 w-full" type="number" name="jumlah" :value="old('jumlah')" required />
                            </div>
                            <div class="flex justify-end mt-4">
                                <x-primary-button>{{ __('Simpan') }}</x-primary-button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="lg:col-span-2">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-medium">Histori Transaksi</h3>
                            <div class="text-right">
                                <p class="text-sm text-gray-500">Saldo Akhir Kas</p>
                                <p class="text-2xl font-bold text-indigo-600">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</p>
                            </div>
                        </div>

                        <form action="{{ route('buku-kas.index') }}" method="GET" class="flex items-center space-x-4 mb-4">
                            <x-text-input type="date" name="start_date" :value="request('start_date')" />
                            <span class="mx-2">s/d</span>
                            <x-text-input type="date" name="end_date" :value="request('end_date')" />
                            <x-primary-button type="submit">Filter</x-primary-button>
                        </form>
                        
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg max-h-96">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
                                    <tr>
                                        <th class="px-6 py-3">Tanggal</th>
                                        <th class="px-6 py-3">Deskripsi</th>
                                        <th class="px-6 py-3">Kategori</th>
                                        <th class="px-6 py-3 text-right">Nominal</th>
                                        <th class="px-6 py-3">Aksi</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y">
                                    @php $saldoBerjalan = 0; @endphp
                                    @forelse ($transaksi as $trx)
                                    <tr>
                                        <td class="px-6 py-4">{{ \Carbon\Carbon::parse($trx->tanggal)->format('d M Y') }}</td>
                                        <td class="px-6 py-4">{{ $trx->deskripsi }}</td>
                                        <td class="px-6 py-4"><span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">{{ $trx->kategori->nama_kategori ?? '-' }}</span></td>
                                        <td class="px-6 py-4 text-right font-semibold {{ $trx->tipe == 'pemasukan' ? 'text-green-600' : 'text-red-600' }}">
                                            {{ $trx->tipe == 'pemasukan' ? '+' : '-' }} Rp {{ number_format($trx->jumlah, 0, ',', '.') }}
                                        </td>
                                        <td class="px-6 py-4 flex items-center space-x-2">
                                            <a href="{{ route('buku-kas.edit', $trx->id) }}" class="text-indigo-600 hover:text-indigo-900 text-xs">Edit</a>
                                            <form action="{{ route('buku-kas.destroy', $trx->id) }}" method="POST" onsubmit="return confirm('Hapus transaksi ini?')">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="text-red-500 hover:text-red-700 text-xs">Hapus</button>
                                            </form>
                                        </td>
                                    </tr>
                                    @empty
                                    <tr><td colspan="5" class="px-6 py-4 text-center">Belum ada transaksi.</td></tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                         <div class="mt-4">
                            {{ $transaksi->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>