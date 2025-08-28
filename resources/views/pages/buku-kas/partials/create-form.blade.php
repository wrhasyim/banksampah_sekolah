<form action="{{ route('buku-kas.store') }}" method="POST">
    @csrf
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        
        {{-- Tanggal --}}
        <div>
            <label for="tanggal" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tanggal</label>
            <input type="date" id="tanggal" name="tanggal" value="{{ old('tanggal', date('Y-m-d')) }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
            @error('tanggal')
                <p class="mt-2 text-sm text-red-500">{{ $message }}</p>
            @enderror
        </div>

        {{-- Keterangan --}}
        <div class="lg:col-span-2">
            <label for="keterangan" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Keterangan</label>
            <input type="text" id="keterangan" name="keterangan" value="{{ old('keterangan') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
            @error('keterangan')
                <p class="mt-2 text-sm text-red-500">{{ $message }}</p>
            @enderror
        </div>

        {{-- Kategori --}}
        <div>
            <label for="id_kategori" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Kategori</label>
            <select id="id_kategori" name="id_kategori" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                <option value="">-- Tanpa Kategori --</option>
                @foreach($kategori as $item)
                    <option value="{{ $item->id }}" {{ old('id_kategori') == $item->id ? 'selected' : '' }}>{{ $item->nama }}</option>
                @endforeach
            </select>
            @error('id_kategori')
                <p class="mt-2 text-sm text-red-500">{{ $message }}</p>
            @enderror
        </div>

        {{-- Tipe Transaksi --}}
        <div>
            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tipe</label>
            <div class="flex items-center space-x-4">
                <div class="flex items-center">
                    <input id="pemasukan" type="radio" value="pemasukan" name="tipe" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600" checked>
                    <label for="pemasukan" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">Pemasukan</label>
                </div>
                <div class="flex items-center">
                    <input id="pengeluaran" type="radio" value="pengeluaran" name="tipe" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600">
                    <label for="pengeluaran" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">Pengeluaran</label>
                </div>
            </div>
             @error('tipe')
                <p class="mt-2 text-sm text-red-500">{{ $message }}</p>
            @enderror
        </div>

        {{-- Jumlah --}}
        <div>
            <label for="jumlah" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jumlah (Rp)</label>
            <input type="number" id="jumlah" name="jumlah" value="{{ old('jumlah') }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
            @error('jumlah')
                <p class="mt-2 text-sm text-red-500">{{ $message }}</p>
            @enderror
        </div>
    </div>
    
    <div class="flex justify-end mt-6">
        <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Simpan Transaksi</button>
    </div>
</form>