<form action="{{ route('laporan.index') }}" method="GET">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
        <div>
            <label for="start_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Dari Tanggal</label>
            <input type="date" id="start_date" name="start_date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600" value="{{ request('start_date', \Carbon\Carbon::now()->startOfMonth()->toDateString()) }}">
        </div>
        <div>
            <label for="end_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Sampai Tanggal</label>
            <input type="date" id="end_date" name="end_date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600" value="{{ request('end_date', \Carbon\Carbon::now()->endOfMonth()->toDateString()) }}">
        </div>
        
        <div class="md:col-span-1">
            <label for="nama_siswa_filter" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Cari Siswa</label>
            <input type="text" id="nama_siswa_filter" name="nama_siswa" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" placeholder="Ketik nama siswa..." value="{{ request('nama_siswa') }}">
        </div>

        <div>
            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jenis Transaksi</label>
            <div class="flex items-center space-x-2">
                <input type="hidden" name="transaction_type" id="transaction_type_input" value="{{ request('transaction_type', 'setoran,penarikan') }}">
                <button type="button" class="btn-filter-jenis w-full p-2.5 text-sm font-medium text-center border rounded-lg" data-value="setoran">Setoran</button>
                <button type="button" class="btn-filter-jenis w-full p-2.5 text-sm font-medium text-center border rounded-lg" data-value="penarikan">Penarikan</button>
            </div>
        </div>
    </div>

    <div class="flex justify-end items-center mb-4">
        <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
            Filter
        </button>
        <a href="{{ route('laporan.index') }}" class="ml-2 text-white bg-gray-500 hover:bg-gray-600 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-gray-400 dark:hover:bg-gray-500 focus:outline-none dark:focus:ring-gray-600">
            Reset
        </a>
        <a href="{{ route('laporan.transaksi.export.excel', request()->query()) }}" class="ml-2 text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-green-600 dark:hover:bg-green-700 focus:outline-none dark:focus:ring-green-800">
            Excel
        </a>
    </div>
</form>

<div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Tanggal</th>
                <th scope="col" class="px-6 py-3">Nama Siswa</th>
                <th scope="col" class="px-6 py-3">Jenis Transaksi</th>
                <th scope="col" class="px-6 py-3">Debit</th>
                <th scope="col" class="px-6 py-3">Kredit</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($transaksi as $item)
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                <td class="px-6 py-4">{{ \Carbon\Carbon::parse($item->tanggal)->translatedFormat('d F Y, H:i') }}</td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ $item->nama }}</td>
                <td class="px-6 py-4">
                    <span class="px-2 py-1 font-semibold leading-tight {{ $item->jenis_transaksi == 'Setoran' ? 'text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100' : 'text-red-700 bg-red-100 rounded-full dark:bg-red-700 dark:text-red-100' }}">
                        {{ $item->jenis_transaksi }}
                    </span>
                </td>
                <td class="px-6 py-4 text-green-600">Rp {{ number_format($item->debit, 0, ',', '.') }}</td>
                <td class="px-6 py-4 text-red-600">Rp {{ number_format($item->kredit, 0, ',', '.') }}</td>
            </tr>
            @empty
            <tr>
                <td colspan="5" class="px-6 py-4 text-center">Tidak ada data transaksi untuk filter yang dipilih.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

<div class="mt-4">
    {{ $transaksi->links() }}
</div>