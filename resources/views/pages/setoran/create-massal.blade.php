<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Buat Setoran Massal') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <form action="{{ route('setoran.storeMassal') }}" method="POST">
                        @csrf
                        <div class="mb-4">
                            <label for="kelas_id" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Kelas</label>
                            <select id="kelas_id" name="kelas_id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                <option value="">-- Pilih Kelas --</option>
                                @foreach($kelasList as $kelas)
                                    <option value="{{ $kelas->id }}">{{ $kelas->nama_kelas }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="jenis_sampah_id" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jenis Sampah</label>
                            <select id="jenis_sampah_id" name="jenis_sampah_id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                <option value="">-- Pilih Jenis Sampah --</option>
                                @foreach($jenisSampahs as $jenis)
                                    <option value="{{ $jenis->id }}">{{ $jenis->nama_sampah }} (Rp {{ number_format($jenis->harga_per_satuan, 0, ',', '.') }}/{{$jenis->satuan}})</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-4 py-3">No</th>
                                        <th scope="col" class="px-4 py-3">Nama Siswa</th>
                                        <th scope="col" class="px-4 py-3">NIS</th>
                                        <th scope="col" class="px-4 py-3">Jumlah (kg/pcs)</th>
                                    </tr>
                                </thead>
                                <tbody id="siswa-table-body">
                                    <tr id="initial-row">
                                        <td colspan="4" class="px-4 py-3 text-center">Pilih kelas untuk menampilkan siswa.</td>
                                    </tr>
                                </tbody>
                                <tbody id="loading-row" style="display: none;">
                                    <tr>
                                        <td colspan="4" class="px-4 py-3 text-center">Memuat data siswa...</td>
                                    </tr>
                                </tbody>
                                <tbody id="error-row" style="display: none;">
                                    <tr>
                                        <td colspan="4" class="px-4 py-3 text-center text-red-500">Gagal memuat data siswa. Coba lagi.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ml-4">
                                {{ __('Simpan') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.getElementById('kelas_id').addEventListener('change', function() {
            var kelasId = this.value;
            var tableBody = document.getElementById('siswa-table-body');
            var initialRow = document.getElementById('initial-row');
            var loadingRow = document.getElementById('loading-row');
            var errorRow = document.getElementById('error-row');

            // Reset table
            tableBody.innerHTML = '';
            if(initialRow) initialRow.style.display = 'none';
            loadingRow.style.display = 'table-row';
            errorRow.style.display = 'none';

            if (kelasId) {
                // --- PERBAIKAN URL FETCH DI SINI ---
                fetch(`/get-siswa-by-kelas/${kelasId}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        loadingRow.style.display = 'none';
                        if (data.length === 0) {
                            tableBody.innerHTML = '<tr><td colspan="4" class="px-4 py-3 text-center">Tidak ada siswa di kelas ini.</td></tr>';
                        } else {
                            data.forEach(function(siswa, index) {
                                var row = `
                                    <tr class="border-b dark:border-gray-700">
                                        <td class="px-4 py-3">${index + 1}</td>
                                        <td class="px-4 py-3">${siswa.pengguna.name}</td>
                                        <td class="px-4 py-3">${siswa.nis}</td>
                                        <td class="px-4 py-3">
                                            <input type="hidden" name="setoran[${index}][siswa_id]" value="${siswa.id}">
                                            <input type="number" name="setoran[${index}][jumlah]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500" value="0" step="0.01" min="0">
                                        </td>
                                    </tr>`;
                                tableBody.innerHTML += row;
                            });
                        }
                    })
                    .catch(error => {
                        loadingRow.style.display = 'none';
                        errorRow.style.display = 'table-row';
                        console.error('Error fetching students:', error);
                    });
            } else {
                loadingRow.style.display = 'none';
                tableBody.innerHTML = '<tr id="initial-row"><td colspan="4" class="px-4 py-3 text-center">Pilih kelas untuk menampilkan siswa.</td></tr>';
            }
        });
    </script>
    @endpush
</x-app-layout>