<form action="{{ route('buku-kas.store') }}" method="POST">
    @csrf
    <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
        <div>
            <label for="tanggal" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal</label>
            <input type="date" id="tanggal" name="tanggal" value="{{ old('tanggal', date('Y-m-d')) }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:text-white" required>
        </div>

        {{-- --- PERBAIKAN DI SINI --- --}}
        <div>
            <label for="deskripsi" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Keterangan</label>
            <input type="text" id="deskripsi" name="deskripsi" value="{{ old('deskripsi') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:text-white" required>
        </div>

        <div>
            <label for="jumlah" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jumlah (Rp)</label>
            <input type="number" id="jumlah" name="jumlah" value="{{ old('jumlah') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:text-white" required>
        </div>
        
        <div>
            <label for="tipe" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tipe Transaksi</label>
            <select id="tipe" name="tipe" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:text-white">
                <option value="pemasukan" @if(old('tipe') == 'pemasukan') selected @endif>Pemasukan</option>
                <option value="pengeluaran" @if(old('tipe') == 'pengeluaran') selected @endif>Pengeluaran</option>
            </select>
        </div>
    </div>
    <div class="flex justify-end mt-4">
        <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Simpan Transaksi</button>
    </div>
</form>