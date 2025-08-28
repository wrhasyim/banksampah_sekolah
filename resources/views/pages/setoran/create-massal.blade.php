<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800">
            {{ __('Tambah Setoran Massal per Kelas') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <form action="{{ route('setoran.store.massal') }}" method="POST">
                        @csrf
                        <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                            {{-- Pilih Kelas --}}
                            <div>
                                <label for="id_kelas" class="block text-sm font-medium text-gray-700">Pilih Kelas</label>
                                <select id="id_kelas" name="id_kelas" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" required>
                                    <option value="">-- Pilih Kelas --</option>
                                    @foreach($kelas as $item)
                                        <option value="{{ $item->id }}">{{ $item->nama_kelas }}</option>
                                    @endforeach
                                </select>
                            </div>
                            {{-- Pilih Jenis Sampah --}}
                            <div>
                                <label for="jenis_sampah_id" class="block text-sm font-medium text-gray-700">Pilih Jenis Sampah (untuk semua)</label>
                                <select id="jenis_sampah_id" name="jenis_sampah_id" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" required>
                                     <option value="">-- Pilih Jenis Sampah --</option>
    @foreach($jenisSampah as $item)
        <option value="{{ $item->id }}">{{ $item->nama_sampah }} (Rp {{ number_format($item->harga_per_satuan, 0, ',', '.') }}/{{ $item->satuan }})</option>
    @endforeach
                                </select>
                            </div>
                        </div>

                        {{-- Daftar Siswa akan muncul di sini --}}
                        <div class="mt-6">
                            <h3 class="text-lg font-medium">Daftar Siswa</h3>
                            <div id="siswa-list-container" class="mt-2 text-gray-500">
                                Silakan pilih kelas terlebih dahulu untuk menampilkan daftar siswa.
                            </div>
                        </div>

                        <div class="flex justify-end mt-6">
                            <button type="submit" id="submit-button" class="px-4 py-2 font-bold text-white bg-green-600 rounded-md hover:bg-green-700" style="display: none;">Simpan Setoran Massal</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
        <script>
            document.getElementById('id_kelas').addEventListener('change', function() {
                const kelasId = this.value;
                const container = document.getElementById('siswa-list-container');
                const submitButton = document.getElementById('submit-button');

                if (!kelasId) {
                    container.innerHTML = 'Silakan pilih kelas terlebih dahulu...';
                    submitButton.style.display = 'none';
                    return;
                }

                container.innerHTML = 'Memuat data siswa...';

                fetch(`/kelas/${kelasId}/siswa`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.length === 0) {
                            container.innerHTML = 'Tidak ada siswa di kelas ini.';
                            submitButton.style.display = 'none';
                            return;
                        }

                        let tableHTML = `
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nama Siswa</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jumlah Setoran (kg)</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">`;

                        data.forEach(siswa => {
                            tableHTML += `
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${siswa.nama}</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <input type="number" name="siswa[${siswa.id}][jumlah]" class="w-full mt-1 border-gray-300 rounded-md shadow-sm" step="0.01" placeholder="0">
                                    </td>
                                </tr>
                            `;
                        });

                        tableHTML += `</tbody></table></div>`;
                        container.innerHTML = tableHTML;
                        submitButton.style.display = 'inline-block';
                    })
                    .catch(error => {
                        container.innerHTML = 'Gagal memuat data siswa. Coba lagi.';
                        submitButton.style.display = 'none';
                    });
            });
        </script>
    @endpush
</x-app-layout>