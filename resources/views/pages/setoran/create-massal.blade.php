<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Setoran Massal per Kelas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <form action="{{ route('setoran.store.massal') }}" method="POST">
                        @csrf
                        <div class="grid grid-cols-1 gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="id_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Kelas</label>
                                <select id="id_kelas" name="id_kelas" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                    <option value="">-- Pilih Kelas --</option>
                                    @foreach($kelas as $item)
                                        <option value="{{ $item->id }}">{{ $item->nama }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div>
                                <label for="id_jenis_sampah" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jenis Sampah</label>
                                <select id="id_jenis_sampah" name="id_jenis_sampah" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                    <option value="">-- Pilih Jenis Sampah --</option>
                                    @foreach($jenisSampah as $item)
                                        <option value="{{ $item->id }}" data-harga="{{ $item->harga }}">{{ $item->nama }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">Nama Siswa</th>
                                        <th scope="col" class="px-6 py-3">NIS</th>
                                        <th scope="col" class="px-6 py-3">Berat (kg)</th>
                                    </tr>
                                </thead>
                                <tbody id="siswa-table-body">
                                    <tr>
                                        <td colspan="3" class="px-6 py-4 text-center">Silakan pilih kelas terlebih dahulu.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <a href="{{ route('setoran.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">
                                Batal
                            </a>
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">
                                Simpan Setoran
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.getElementById('id_kelas').addEventListener('change', function () {
            var kelasId = this.value;
            var tableBody = document.getElementById('siswa-table-body');
            
            // PERBAIKAN: Menggunakan route() helper untuk URL yang dinamis dan aman
            var url = '{{ route("siswa.get-by-kelas", ["id_kelas" => ":id_kelas"]) }}';
            url = url.replace(':id_kelas', kelasId);

            tableBody.innerHTML = '<tr><td colspan="3" class="px-6 py-4 text-center">Memuat data siswa...</td></tr>';

            if (!kelasId) {
                tableBody.innerHTML = '<tr><td colspan="3" class="px-6 py-4 text-center">Silakan pilih kelas terlebih dahulu.</td></tr>';
                return;
            }

            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    tableBody.innerHTML = '';
                    if (data.length === 0) {
                        tableBody.innerHTML = '<tr><td colspan="3" class="px-6 py-4 text-center">Tidak ada siswa di kelas ini.</td></tr>';
                    } else {
                        data.forEach(siswa => {
                            let row = `
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="px-6 py-4">${siswa.nama}</td>
                                    <td class="px-6 py-4">${siswa.nis || ''}</td>
                                    <td class="px-6 py-4">
                                        <input type="hidden" name="id_siswa[]" value="${siswa.id}">
                                        <input type="number" name="berat[]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" step="0.01" value="0">
                                    </td>
                                </tr>`;
                            tableBody.innerHTML += row;
                        });
                    }
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                    tableBody.innerHTML = '<tr><td colspan="3" class="px-6 py-4 text-center text-red-500">Gagal memuat data siswa. Coba lagi.</td></tr>';
                });
        });
    </script>
    @endpush
</x-app-layout>