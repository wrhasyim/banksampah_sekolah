<form method="GET" action="{{ route('laporan.index') }}" class="mb-4" id="filter-form">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 items-end">
        {{-- Filter Tanggal Mulai --}}
        <div>
            <label for="start_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Mulai</label>
            <input type="date" name="start_date" id="start_date" value="{{ request('start_date') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
        </div>

        {{-- Filter Tanggal Selesai --}}
        <div>
            <label for="end_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal Selesai</label>
            <input type="date" name="end_date" id="end_date" value="{{ request('end_date') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
        </div>

        {{-- Filter Siswa --}}
        <div>
            <label for="siswa_id" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Siswa</label>
            <select name="siswa_id" id="siswa_id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                <option value="">Semua Siswa</option>
                @foreach($siswaList as $siswa)
                    <option value="{{ $siswa->id }}" {{ request('siswa_id') == $siswa->id ? 'selected' : '' }}>
                        {{ $siswa->pengguna->nama_lengkap }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- Filter Jenis Transaksi (Tampilan Baru) --}}
        <div>
            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jenis Transaksi</label>
            <input type="hidden" name="transaction_type" id="transaction_type_input" value="{{ is_array(request('transaction_type')) ? implode(',', request('transaction_type')) : request('transaction_type', '') }}">
            <div id="transaction-type-btns" class="flex rounded-lg shadow-sm" role="group">
                <button type="button" data-value="setoran" class="btn-filter-jenis flex-1 px-4 py-2 text-sm font-medium border rounded-l-lg">
                    📥 Setoran
                </button>
                <button type="button" data-value="penarikan" class="btn-filter-jenis flex-1 px-4 py-2 text-sm font-medium border-t border-b">
                    📤 Penarikan
                </button>
            </div>
        </div>
    </div>

    {{-- Tombol Aksi --}}
    <div class="mt-6 flex flex-col sm:flex-row justify-between items-center">
        <button type="submit" class="w-full sm:w-auto inline-flex items-center justify-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 mb-2 sm:mb-0">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v10a1 1 0 01-1 1H4a1 1 0 01-1-1V10zM15 10a1 1 0 011-1h5a1 1 0 011 1v4a1 1 0 01-1 1h-5a1 1 0 01-1-1v-4z"></path></svg>
            Filter
        </button>
        <div class="flex space-x-2">
            <a href="{{ route('laporan.transaksi.export.excel', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-green-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-green-700">
                <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M2 5a2 2 0 012-2h12a2 2 0 012 2v10a2 2 0 01-2 2H4a2 2 0 01-2-2V5zm2-1a1 1 0 00-1 1v10a1 1 0 001 1h12a1 1 0 001-1V5a1 1 0 00-1-1H4z" clip-rule="evenodd"></path><path d="M13.586 7.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0l-3-3a2 2 0 112.828-2.828L12 9.172l1.586-1.586z"></path></svg>
                Excel
            </a>
            <a href="{{ route('laporan.transaksi.export.pdf', request()->query()) }}" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700">
                <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M5 2a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V4a2 2 0 00-2-2H5zm0 2h10v12H5V4zm5 8a1 1 0 110-2 1 1 0 010 2z" clip-rule="evenodd"></path></svg>
                PDF
            </a>
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
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->format('d-m-Y') }}</td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ $item->nama }}</td>
                <td class="px-6 py-4">
                    @if($item->jenis_transaksi == 'Setoran')
                        <span class="bg-green-100 text-green-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">Setoran</span>
                    @else
                        <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300">Penarikan</span>
                    @endif
                </td>
                <td class="px-6 py-4 text-green-600">Rp. {{ number_format($item->debit, 0, ',', '.') }}</td>
                <td class="px-6 py-4 text-red-600">Rp. {{ number_format($item->kredit, 0, ',', '.') }}</td>
            </tr>
            @empty
            <tr>
                <td colspan="5" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                    Tidak ada data transaksi yang cocok dengan filter yang Anda pilih.
                </td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

<div class="mt-4">
    {{ $transaksi->links() }}
</div>