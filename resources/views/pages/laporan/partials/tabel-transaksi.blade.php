<form method="GET" action="{{ route('laporan.index') }}" class="mb-4">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div>
            <label for="start_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
            <input type="date" name="start_date" id="start_date" value="{{ request('start_date') }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
        </div>
        <div>
            <label for="end_date" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
            <input type="date" name="end_date" id="end_date" value="{{ request('end_date') }}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
        </div>
        <div>
            <label for="siswa_id" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Siswa</label>
            <select name="siswa_id" id="siswa_id" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
                <option value="">Semua Siswa</option>
                @foreach($siswaList as $siswa)
                    <option value="{{ $siswa->id }}" {{ request('siswa_id') == $siswa->id ? 'selected' : '' }}>
                        {{ $siswa->pengguna->nama_lengkap }}
                    </option>
                @endforeach
            </select>
        </div>
        <div>
            <label for="transaction_type" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Jenis Transaksi</label>
            <select name="transaction_type[]" id="transaction_type" multiple class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600">
                <option value="setoran" {{ (is_array(request('transaction_type')) && in_array('setoran', request('transaction_type'))) ? 'selected' : '' }}>Setoran</option>
                <option value="penarikan" {{ (is_array(request('transaction_type')) && in_array('penarikan', request('transaction_type'))) ? 'selected' : '' }}>Penarikan</option>
            </select>
        </div>
    </div>
    <div class="mt-4 flex justify-between">
        <button type="submit" class="inline-flex items-center px-4 py-2 bg-blue-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-600">Filter</button>
        <div>
            <a href="{{ route('laporan.transaksi.export.excel', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-green-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-green-600">Export Excel</a>
            <a href="{{ route('laporan.transaksi.export.pdf', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-red-500 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-600">Export PDF</a>
        </div>
    </div>
</form>

<div class="relative overflow-x-auto shadow-md sm:rounded-lg mt-6">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Tanggal</th>
                <th scope="col" class="px-6 py-3">Nama</th>
                <th scope="col" class="px-6 py-3">Jenis Transaksi</th>
                <th scope="col" class="px-6 py-3">Debit</th>
                <th scope="col" class="px-6 py-3">Kredit</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($transaksi as $item)
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d-m-Y') }}</td>
                <td class="px-6 py-4">{{ $item->nama }}</td>
                <td class="px-6 py-4">{{ $item->jenis_transaksi }}</td>
                <td class="px-6 py-4">Rp. {{ number_format($item->debit, 0, ',', '.') }}</td>
                <td class="px-6 py-4">Rp. {{ number_format($item->kredit, 0, ',', '.') }}</td>
            </tr>
            @empty
            <tr>
                <td colspan="5" class="px-6 py-4 text-center">Tidak ada data transaksi sesuai filter.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

<div class="mt-4">
    {{ $transaksi->links() }}
</div>