<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800">
            {{ __('Tambah Setoran Sampah') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('setoran.store') }}" method="POST" id="setoranForm">
                        @csrf
                        <div class="mb-4">
                         <label for="siswa_id" class="block text-sm font-medium text-gray-700">Pilih Siswa</label>
<select name="siswa_id" id="siswa_id" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" required>
    <option value="">-- Pilih Siswa --</option>
    @foreach($siswa as $item)
        <option value="{{ $item->id }}">{{ $item->pengguna->nama_lengkap }} - {{ $item->kelas->nama_kelas }}</option>
    @endforeach
</select>
                            @error('siswa_id')
                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                            @enderror
                        </div>

                        <div id="sampah-container">
                            <div class="p-4 mb-4 border rounded-md sampah-item">
                                <div class="grid grid-cols-1 gap-4 md:grid-cols-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Jenis Sampah</label>
                                        <select name="sampah[0][jenis_sampah_id]" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" required>
                                            @foreach($jenisSampah as $item)
        <option value="{{ $item->id }}" data-harga="{{ $item->harga_per_satuan }}">{{ $item->nama_sampah }}</option>
    @endforeach
                                        </select>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Jumlah (kg)</label>
                                        <input type="number" name="sampah[0][jumlah]" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" step="0.01" required>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Harga per Kg</label>
                                        <input type="text" class="w-full mt-1 bg-gray-100 border-gray-300 rounded-md shadow-sm harga-kg" readonly>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Subtotal</label>
                                        <input type="text" class="w-full mt-1 bg-gray-100 border-gray-300 rounded-md shadow-sm subtotal" readonly>
                                    </div>
                                </div>
                                <button type="button" class="px-2 py-1 mt-2 text-xs text-red-500 hover:text-red-700 remove-sampah">Hapus</button>
                            </div>
                        </div>

                        <button type="button" id="add-sampah" class="px-4 py-2 mb-4 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700">Tambah Jenis Sampah</button>

                        <div class="text-right">
                            <h3 class="text-lg font-semibold">Total: <span id="total-keseluruhan">Rp 0</span></h3>
                        </div>

                        <div class="flex justify-end mt-6">
                            <button type="submit" class="px-4 py-2 font-bold text-white bg-green-600 rounded-md hover:bg-green-700">Simpan Setoran</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Inisialisasi TomSelect untuk dropdown siswa
                new TomSelect('#siswa_id', {
                    valueField: 'id',
                    labelField: 'text',
                    searchField: 'text',
                    create: false,
                    // Konfigurasi untuk remote data (AJAX)
                    load: function(query, callback) {
                        if (!query.length) return callback();
                        fetch(`{{ route('setoran.getSiswa') }}?q=${encodeURIComponent(query)}`)
                            .then(response => response.json())
                            .then(data => {
                                callback(data);
                            }).catch(() => {
                                callback();
                            });
                    },
                    // Teks placeholder saat loading atau tidak ada hasil
                    render: {
                        option: function(data, escape) {
                            return `<div>${escape(data.text)}</div>`;
                        },
                        no_results: function(data, escape) {
                            return '<div class="p-2 text-center text-gray-500">Siswa tidak ditemukan.</div>';
                        },
                    },
                    placeholder: 'Ketik untuk mencari nama siswa...'
                });

                let sampahIndex = 1;

                // Fungsi untuk menambah baris sampah baru
                document.getElementById('add-sampah').addEventListener('click', function() {
                    const container = document.getElementById('sampah-container');
                    const newItem = document.createElement('div');
                    newItem.classList.add('p-4', 'mb-4', 'border', 'rounded-md', 'sampah-item');
                    newItem.innerHTML = `
                        <div class="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Jenis Sampah</label>
                                <select name="sampah[${sampahIndex}][jenis_sampah_id]" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" required>
                                    @foreach($jenisSampah as $item)
        <option value="{{ $item->id }}" data-harga="{{ $item->harga_per_satuan }}">{{ $item->nama_sampah }}</option>
    @endforeach
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Jumlah (kg)</label>
                                <input type="number" name="sampah[${sampahIndex}][jumlah]" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" step="0.01" required>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Harga per Kg</label>
                                <input type="text" class="w-full mt-1 bg-gray-100 border-gray-300 rounded-md shadow-sm harga-kg" readonly>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Subtotal</label>
                                <input type="text" class="w-full mt-1 bg-gray-100 border-gray-300 rounded-md shadow-sm subtotal" readonly>
                            </div>
                        </div>
                        <button type="button" class="px-2 py-1 mt-2 text-xs text-red-500 hover:text-red-700 remove-sampah">Hapus</button>
                    `;
                    container.appendChild(newItem);
                    sampahIndex++;
                });

                // Fungsi untuk menghitung ulang total dan subtotal
                function calculateTotals() {
                    let totalKeseluruhan = 0;
                    document.querySelectorAll('.sampah-item').forEach(item => {
                        const select = item.querySelector('select');
                        const jumlahInput = item.querySelector('input[type="number"]');
                        const hargaKgInput = item.querySelector('.harga-kg');
                        const subtotalInput = item.querySelector('.subtotal');
                        
                        const harga = parseFloat(select.options[select.selectedIndex].dataset.harga) || 0;
                        const jumlah = parseFloat(jumlahInput.value) || 0;
                        const subtotal = harga * jumlah;

                        hargaKgInput.value = 'Rp ' + harga.toLocaleString('id-ID');
                        subtotalInput.value = 'Rp ' + subtotal.toLocaleString('id-ID');
                        totalKeseluruhan += subtotal;
                    });
                    document.getElementById('total-keseluruhan').textContent = 'Rp ' + totalKeseluruhan.toLocaleString('id-ID');
                }

                // Event listener untuk perubahan pada kontainer sampah
                document.getElementById('sampah-container').addEventListener('change', function(e) {
                    if (e.target.tagName === 'SELECT' || e.target.tagName === 'INPUT') {
                        calculateTotals();
                    }
                });
                document.getElementById('sampah-container').addEventListener('input', function(e) {
                    if (e.target.tagName === 'INPUT') {
                        calculateTotals();
                    }
                });

                // Event listener untuk tombol hapus
                document.getElementById('sampah-container').addEventListener('click', function(e) {
                    if (e.target.classList.contains('remove-sampah')) {
                        e.target.closest('.sampah-item').remove();
                        calculateTotals();
                    }
                });

                // Panggil kalkulasi saat halaman pertama kali dimuat
                calculateTotals();
            });
        </script>
    @endpush
</x-app-layout>