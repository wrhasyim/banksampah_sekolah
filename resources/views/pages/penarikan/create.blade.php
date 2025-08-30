<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Buat Penarikan Baru (Per Siswa)') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <form action="{{ route('penarikan.store') }}" method="POST">
                        @csrf
                        <div class="mb-4">
                            <label for="id_siswa" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pilih Siswa</label>
                            <select id="id_siswa" name="id_siswa" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
                                <option value="" disabled selected>-- Pilih Siswa --</option>
                                @forelse($siswas as $siswa)
                                    <option value="{{ $siswa->id }}" data-saldo="{{ $siswa->saldo }}">
                                        {{ $siswa->pengguna->nama_lengkap }} (Saldo: Rp {{ number_format($siswa->saldo, 0, ',', '.') }})
                                    </option>
                                @empty
                                    <option disabled>Tidak ada siswa dengan saldo yang bisa ditarik.</option>
                                @endforelse
                            </select>
                        </div>
                        
                        <div class="mb-4">
                            <label for="jumlah_penarikan" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Jumlah Penarikan (Rp)</label>
                            <input type="number" id="jumlah_penarikan" name="jumlah_penarikan" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white" required>
                            <p id="saldo-helper" class="mt-2 text-sm text-gray-500 dark:text-gray-400" style="display: none;">
                                Saldo tersedia: <span id="saldo-text" class="font-bold"></span>
                            </p>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <a href="{{ route('penarikan.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">Batal</a>
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Tarik Saldo</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    @push('scripts')
    <script>
        document.getElementById('id_siswa').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const saldo = selectedOption.getAttribute('data-saldo');
            const saldoHelper = document.getElementById('saldo-helper');
            const saldoText = document.getElementById('saldo-text');
            const jumlahInput = document.getElementById('jumlah_penarikan');

            if (saldo) {
                saldoText.textContent = 'Rp ' + new Intl.NumberFormat('id-ID').format(saldo);
                saldoHelper.style.display = 'block';
                jumlahInput.max = saldo;
            } else {
                saldoHelper.style.display = 'none';
                jumlahInput.removeAttribute('max');
            }
        });
    </script>
    @endpush
</x-app-layout>