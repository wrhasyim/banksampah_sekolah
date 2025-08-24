<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Catat Setoran Baru') }}
        </h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if (session('error'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('error') }}</span>
                        </div>
                    @endif
                    <form action="{{ route('setoran.store') }}" method="POST">
                        @csrf
                        <div class="mt-4">
                            <x-input-label for="id_kelas" value="Pilih Kelas" />
                            <select name="id_kelas" id="id_kelas" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Kelas --</option>
                                @foreach ($kelas as $item)
                                    <option value="{{ $item->id }}">{{ $item->nama_kelas }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="mt-4">
                            <x-input-label for="id_siswa" value="Pilih Siswa" />
                            <select name="id_siswa" id="id_siswa" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Kelas Terlebih Dahulu --</option>
                            </select>
                            <x-input-error :messages="$errors->get('id_siswa')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="id_jenis_sampah" value="Jenis Sampah" />
                            <select name="id_jenis_sampah" id="id_jenis_sampah" class="block mt-1 w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" required>
                                <option value="">-- Pilih Jenis Sampah --</option>
                                @foreach ($jenisSampah as $item)
                                    <option value="{{ $item->id }}">
                                        {{ $item->nama_sampah }} (Rp {{ number_format($item->harga_per_satuan, 0, ',', '.') }})
                                    </option>
                                @endforeach
                            </select>
                            <x-input-error :messages="$errors->get('id_jenis_sampah')" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <x-input-label for="jumlah_satuan" value="Jumlah (pcs/satuan)" />
                            <x-text-input id="jumlah_satuan" class="block mt-1 w-full" type="number" name="jumlah_satuan" :value="old('jumlah_satuan')" required />
                            <x-input-error :messages="$errors->get('jumlah_satuan')" class="mt-2" />
                        </div>
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button class="ms-4">
                                {{ __('Simpan Transaksi') }}
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.getElementById('id_kelas').addEventListener('change', function() {
            let kelasId = this.value;
            let siswaSelect = document.getElementById('id_siswa');
            siswaSelect.innerHTML = '<option value="">Memuat siswa...</option>';

            if (kelasId) {
                // Gunakan route() helper untuk URL yang aman
                fetch(`{{ url('/get-siswa-by-kelas') }}/${kelasId}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        siswaSelect.innerHTML = '<option value="">-- Pilih Siswa --</option>';
                        if (data.length > 0) {
                            data.forEach(function(siswa) {
                                let option = document.createElement('option');
                                option.value = siswa.id;
                                option.textContent = siswa.pengguna.nama_lengkap;
                                siswaSelect.appendChild(option);
                            });
                        } else {
                            siswaSelect.innerHTML = '<option value="">Tidak ada siswa di kelas ini</option>';
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching students:', error);
                        siswaSelect.innerHTML = '<option value="">Gagal memuat siswa</option>';
                    });
            } else {
                siswaSelect.innerHTML = '<option value="">-- Pilih Kelas Terlebih Dahulu --</option>';
            }
        });
    </script>
    @endpush
</x-app-layout>