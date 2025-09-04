<div class="relative mt-6 overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Tanggal</th>
                <th scope="col" class="px-6 py-3">Keterangan</th>
                <th scope="col" class="px-6 py-3">Kategori</th>
                <th scope="col" class="px-6 py-3">Tipe</th>
                <th scope="col" class="px-6 py-3">Jumlah</th>
                <th scope="col" class="px-6 py-3">Aksi</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($bukuKas as $item)
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d F Y') }}</td>
                <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                
                {{-- Menampilkan Nama Kategori dari relasi --}}
                <td class="px-6 py-4">{{ $item->kategori->nama_kategori ?? '-' }}</td>
                
                <td class="px-6 py-4">
                    @if ($item->tipe == 'pemasukan')
                    <span class="px-2 py-1 text-xs font-medium text-green-800 bg-green-100 rounded-full dark:bg-green-900 dark:text-green-300">Pemasukan</span>
                    @else
                    <span class="px-2 py-1 text-xs font-medium text-red-800 bg-red-100 rounded-full dark:bg-red-900 dark:text-red-300">Pengeluaran</span>
                    @endif
                </td>
                <td class="px-6 py-4 font-medium">Rp. {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                <td class="px-6 py-4">
                    <a href="{{ route('buku-kas.edit', $item->id) }}" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit</a>
                    <form action="{{ route('buku-kas.destroy', $item->id) }}" method="POST" class="inline-block" onsubmit="return confirm('Yakin ingin menghapus transaksi ini?');">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="ml-2 font-medium text-red-600 dark:text-red-500 hover:underline">Hapus</button>
                    </form>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="6" class="px-6 py-4 text-center">Tidak ada transaksi untuk bulan ini.</td>
            </tr>
            @endforelse
        </tbody>
        <tfoot class="font-semibold text-gray-900 bg-gray-50 dark:text-white dark:bg-gray-700">
            <tr>
                <td colspan="4" class="px-6 py-3 text-right">Total Pemasukan (Bulan Ini):</td>
                <td colspan="2" class="px-6 py-3 text-green-500">Rp. {{ number_format($totalPemasukan, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td colspan="4" class="px-6 py-3 text-right">Total Pengeluaran (Bulan Ini):</td>
                <td colspan="2" class="px-6 py-3 text-red-500">Rp. {{ number_format($totalPengeluaran, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td colspan="4" class="px-6 py-3 text-lg text-right">Saldo Akhir (Keseluruhan):</td>
                <td colspan="2" class="px-6 py-3 text-lg">Rp. {{ number_format($saldoAkhir, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</div>
<div class="mt-4">
    {{ $bukuKas->links() }}
</div>