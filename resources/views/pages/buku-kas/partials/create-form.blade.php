<form action="{{ route('buku-kas.store') }}" method="POST">
    @csrf
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
            <x-input-label for="tanggal" :value="__('Tanggal')" />
            <x-text-input id="tanggal" class="block mt-1 w-full" type="date" name="tanggal" :value="old('tanggal', date('Y-m-d'))" required />
        </div>
        
        {{-- Dropdown Kategori --}}
        <div>
            <x-input-label for="id_kategori" :value="__('Kategori (Opsional)')" />
            <select name="id_kategori" id="id_kategori_create" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm">
                <option value="">-- Tanpa Kategori --</option>
                @foreach($kategoriTransaksi as $kategori)
                    {{-- Tambahkan atribut data-tipe untuk JavaScript --}}
                    <option value="{{ $kategori->id }}" data-tipe="{{ $kategori->tipe }}">{{ $kategori->nama_kategori }}</option>
                @endforeach
            </select>
        </div>

        <div>
            <x-input-label for="tipe" :value="__('Tipe Transaksi')" />
            <select name="tipe" id="tipe_create" class="block mt-1 w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm">
                <option value="pemasukan">Pemasukan</option>
                <option value="pengeluaran">Pengeluaran</option>
            </select>
        </div>
    </div>
    <div class="mt-4">
        <x-input-label for="deskripsi" :value="__('Deskripsi')" />
        <x-text-input id="deskripsi" class="block mt-1 w-full" type="text" name="deskripsi" :value="old('deskripsi')" required />
    </div>
    <div class="mt-4">
        <x-input-label for="jumlah" :value="__('Jumlah (Rp)')" />
        <x-text-input id="jumlah" class="block mt-1 w-full" type="number" name="jumlah" :value="old('jumlah')" required />
    </div>
    <div class="flex items-center justify-end mt-4">
        <x-primary-button>
            {{ __('Simpan Transaksi') }}
        </x-primary-button>
    </div>
</form>

@push('scripts')
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const kategoriSelect = document.getElementById('id_kategori_create');
        const tipeSelect = document.getElementById('tipe_create');

        kategoriSelect.addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            const tipe = selectedOption.getAttribute('data-tipe');

            if (tipe) {
                tipeSelect.value = tipe;
                tipeSelect.disabled = true;
            } else {
                tipeSelect.disabled = false;
            }
        });
    });
</script>
@endpush