<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buat Penarikan Baru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <form action="{{ route('penarikan.store') }}" method="POST">
                        @csrf
                        
                        <div class="mb-4">
                            <x-input-label for="id_siswa" value="Pilih Siswa (Ketik untuk mencari)" />
                            <select name="id_siswa" id="id_siswa" class="select2 block mt-1 w-full" required>
                                <option value="">-- Pilih Siswa --</option>
                                @foreach($siswa as $item)
                                    <option value="{{ $item->id }}" data-saldo="{{ $item->saldo }}">
                                        {{ $item->pengguna->nama_lengkap }} (Saldo: Rp {{ number_format($item->saldo, 0, ',', '.') }})
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-4">
                            <x-input-label for="jumlah_penarikan" value="Jumlah Penarikan (Rp)" />
                            <x-text-input type="number" id="jumlah_penarikan" name="jumlah_penarikan" class="block mt-1 w-full" required />
                            <small id="saldo-info" class="text-gray-500 mt-1 block"></small>
                        </div>

                        <div class="flex justify-end">
                            <x-primary-button>
                                Simpan Transaksi
                            </x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            // Inisialisasi Select2 pada elemen dengan class 'select2'
            $('.select2').select2({
                placeholder: 'Ketik nama siswa...',
                width: '100%'
            });

            // Tampilkan sisa saldo siswa saat dipilih
            $('#id_siswa').on('change', function() {
                var saldo = $(this).find(':selected').data('saldo');
                if (saldo) {
                    $('#saldo-info').text('Saldo tersedia: Rp ' + new Intl.NumberFormat('id-ID').format(saldo));
                } else {
                    $('#saldo-info').text('');
                }
            });
        });
    </script>
    @endpush
</x-app-layout>