<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buat Setoran Massal Baru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">

                    <div class="mb-4">
                        <label for="kelas_filter" class="block font-medium text-sm text-gray-700">Filter Berdasarkan Kelas</label>
                        <select id="kelas_filter" name="kelas_filter" class="block w-full mt-1 rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                            <option value="">-- Pilih Kelas --</option>
                            @foreach ($kelasList as $kelas)
                                <option value="{{ $kelas->id }}" data-nama-kelas="{{ $kelas->nama_kelas }}">{{ $kelas->nama_kelas }}</option>
                            @endforeach
                        </select>
                    </div>

                    <form action="{{ route('setoran.storeMassal') }}" method="POST">
                        @csrf
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <tr>
                                        <td id="initial-message" class="text-center p-4">
                                            Silakan pilih kelas terlebih dahulu untuk menampilkan siswa.
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button>
                                {{ __('Simpan Semua Setoran') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const kelasFilter = document.getElementById('kelas_filter');
            const tableHead = document.querySelector('thead');
            const tableBody = document.querySelector('tbody');
            const initialMessage = document.getElementById('initial-message');

            // Mengambil data jenis sampah dari PHP ke JavaScript
            const jenisSampahSiswa = @json($jenisSampahSiswa->values());
            const jenisSampahGuru = @json($jenisSampahGuru->values());

            kelasFilter.addEventListener('change', function () {
                const selectedOption = this.options[this.selectedIndex];
                const kelasId = selectedOption.value;
                const namaKelas = selectedOption.getAttribute('data-nama-kelas');
                
                const isGuruClass = namaKelas && namaKelas.toLowerCase().includes('guru');
                const activeJenisSampah = isGuruClass ? jenisSampahGuru : jenisSampahSiswa;
                
                tableHead.innerHTML = '';
                tableBody.innerHTML = `<tr><td colspan="${activeJenisSampah.length + 1}" class="text-center p-4">Memuat data siswa...</td></tr>`;

                if (kelasId) {
                    // 1. Bangun Header Tabel
                    let headerRow = '<tr>';
                    headerRow += '<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider sticky left-0 bg-gray-50 z-10">Nama Siswa</th>';
                    activeJenisSampah.forEach(sampah => {
                        // --- PERUBAHAN DI SINI ---
                        // Menggunakan 'sampah.satuan' untuk menampilkan unit dinamis
                        headerRow += `<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">${sampah.nama_sampah} (${sampah.satuan})</th>`;
                    });
                    headerRow += '</tr>';
                    tableHead.innerHTML = headerRow;

                    // 2. Ambil dan Bangun Body Tabel
                    fetch(`{{ url('/api/siswa-by-kelas') }}/${kelasId}`)
                        .then(response => response.json())
                        .then(data => {
                            tableBody.innerHTML = ''; 
                            if (data.length > 0) {
                                data.forEach(siswa => {
                                    let bodyRow = '<tr>';
                                    bodyRow += `<td class="px-6 py-4 whitespace-nowrap sticky left-0 bg-white z-10">${siswa.pengguna.nama_lengkap}</td>`;
                                    
                                    activeJenisSampah.forEach(sampah => {
                                        bodyRow += `<td class="px-6 py-4 whitespace-nowrap">
                                                    <input type="number" step="0.01" min="0" 
                                                           name="setoran[${siswa.id}][${sampah.id}]" 
                                                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                                                           placeholder="0">
                                                </td>`;
                                    });
                                    bodyRow += '</tr>';
                                    tableBody.innerHTML += bodyRow;
                                });
                            } else {
                                tableBody.innerHTML = `<tr><td colspan="${activeJenisSampah.length + 1}" class="text-center p-4">Tidak ada siswa di kelas ini.</td></tr>`;
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching siswa:', error);
                            tableBody.innerHTML = `<tr><td colspan="${activeJenisSampah.length + 1}" class="text-center p-4">Gagal memuat data siswa. Pastikan route API sudah benar.</td></tr>`;
                        });
                } else {
                    tableHead.innerHTML = '';
                    tableBody.innerHTML = `<tr><td class="text-center p-4">Silakan pilih kelas terlebih dahulu.</td></tr>`;
                }
            });
        });
    </script>
    @endpush
</x-app-layout>