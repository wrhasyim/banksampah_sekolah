<div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th class="px-6 py-3">Tanggal</th>
                <th class="px-6 py-3">Nama Siswa</th>
                <th class="px-6 py-3">Kelas</th>
                <th class="px-6 py-3">Deskripsi</th>
                <th class="px-6 py-3">Kredit</th>
                <th class="px-6 py-3">Debit</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($results as $item)
            <tr class="bg-white border-b">
                <td class="px-6 py-4">{{ $item->tanggal->format('d M Y') }}</td>
                <td class="px-6 py-4 font-medium">{{ $item->nama_siswa }}</td>
                <td class="px-6 py-4">{{ $item->nama_kelas }}</td>
                <td class="px-6 py-4">{{ $item->deskripsi }}</td>
                <td class="px-6 py-4 text-green-600">{{ $item->kredit > 0 ? 'Rp '.number_format($item->kredit, 0, ',', '.') : '' }}</td>
                <td class="px-6 py-4 text-red-600">{{ $item->debit > 0 ? 'Rp '.number_format($item->debit, 0, ',', '.') : '' }}</td>
            </tr>
            @empty
            <tr><td colspan="6" class="px-6 py-4 text-center">Tidak ada data untuk ditampilkan.</td></tr>
            @endforelse
        </tbody>
    </table>
</div>