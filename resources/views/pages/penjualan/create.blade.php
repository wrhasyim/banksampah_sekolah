<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Catat Penjualan Baru') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                @if ($errors->any())
                    <div class="mb-4 bg-red-100 border-red-400 text-red-700 px-4 py-3 rounded"><ul class="list-disc list-inside">@foreach ($errors->all() as $error)<li>{{ $error }}</li>@endforeach</ul></div>
                @endif
                <form action="{{ route('penjualan.store') }}" method="POST">
                    @csrf
                    <div>
                        <x-input-label for="nama_pengepul" value="Nama Pengepul" />
                        <x-text-input id="nama_pengepul" class="block mt-1 w-full" type="text" name="nama_pengepul" :value="old('nama_pengepul')" required autofocus />
                    </div>
                    <div class="mt-6">
                        <h3 class="text-lg font-medium">Item Sampah yang Dijual</h3>
                        <div id="items-container" class="mt-4 space-y-4"></div>
                        <button type="button" id="add-item-btn" class="mt-4 text-sm text-indigo-600 hover:text-indigo-900">+ Tambah Item Sampah</button>
                    </div>
                    <div class="flex items-center justify-end mt-6">
                        <x-primary-button>{{ __('Simpan Penjualan') }}</x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.getElementById('items-container');
            const addItemBtn = document.getElementById('add-item-btn');
            const sampahData = @json($jenisSampah->keyBy('id')); // Ubah format data agar mudah dicari
            let itemIndex = 0;

            function createItemRow() {
                const itemRow = document.createElement('div');
                itemRow.classList.add('p-4', 'border', 'rounded-md', 'grid', 'grid-cols-12', 'gap-4', 'items-center');
                
                itemRow.innerHTML = `
                    <div class="col-span-12 md:col-span-5">
                        <label class="block text-sm font-medium text-gray-700">Jenis Sampah</label>
                        <select name="items[${itemIndex}][id_jenis_sampah]" class="item-select mt-1 block w-full border-gray-300 rounded-md" required>
                            <option value="">-- Pilih Sampah --</option>
                            ${Object.values(sampahData).map(sampah => `<option value="${sampah.id}">${sampah.nama_sampah} (Stok: ${sampah.stok} ${sampah.satuan})</option>`).join('')}
                        </select>
                    </div>
                    <div class="col-span-6 md:col-span-3">
                        <label class="block text-sm font-medium text-gray-700">Jumlah</label>
                        <div class="flex items-center">
                            <input type="number" step="0.01" name="items[${itemIndex}][jumlah]" class="mt-1 block w-full border-gray-300 rounded-md" required min="0.01">
                            <span class="unit-label ml-2 text-gray-500 text-sm"></span>
                        </div>
                    </div>
                    <div class="col-span-6 md:col-span-3">
                        <label class="block text-sm font-medium text-gray-700">Harga Jual (Rp)</label>
                        <input type="number" name="items[${itemIndex}][subtotal_harga]" class="mt-1 block w-full border-gray-300 rounded-md" required min="0">
                    </div>
                    <div class="col-span-12 md:col-span-1 flex items-end justify-end">
                        <button type="button" class="remove-item-btn text-red-600 hover:text-red-900">Hapus</button>
                    </div>
                `;
                container.appendChild(itemRow);
                
                // Tambahkan event listener ke select yang baru dibuat
                const selectElement = itemRow.querySelector('.item-select');
                const unitLabel = itemRow.querySelector('.unit-label');
                
                selectElement.addEventListener('change', function() {
                    const selectedId = this.value;
                    if (selectedId && sampahData[selectedId]) {
                        unitLabel.textContent = sampahData[selectedId].satuan;
                    } else {
                        unitLabel.textContent = '';
                    }
                });

                itemRow.querySelector('.remove-item-btn').addEventListener('click', () => itemRow.remove());
                itemIndex++;
            }

            addItemBtn.addEventListener('click', createItemRow);
            createItemRow();
        });
    </script>
    @endpush
</x-app-layout>