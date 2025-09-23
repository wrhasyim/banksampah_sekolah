<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buat Penjualan Baru') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">

                    @if(session('error'))
                        <div class="mb-4 p-4 bg-red-100 text-red-700 border border-red-200 rounded-md">
                            {{ session('error') }}
                        </div>
                    @endif

                    <form action="{{ route('penjualan.store') }}" method="POST">
                        @csrf
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                            <div>
                                <x-input-label for="tanggal_penjualan" :value="__('Tanggal Penjualan')" />
                                <x-text-input id="tanggal_penjualan" class="block mt-1 w-full" type="date" name="tanggal_penjualan" :value="old('tanggal_penjualan', date('Y-m-d'))" required />
                                <x-input-error :messages="$errors->get('tanggal_penjualan')" class="mt-2" />
                            </div>
                            <div>
                                <x-input-label for="nama_pengepul" :value="__('Nama Pengepul')" />
                                <x-text-input id="nama_pengepul" class="block mt-1 w-full" type="text" name="nama_pengepul" :value="old('nama_pengepul')" required />
                                <x-input-error :messages="$errors->get('nama_pengepul')" class="mt-2" />
                            </div>
                        </div>
                        
                        <h3 class="text-lg font-semibold border-t pt-4 mb-4">Item Sampah untuk Dijual</h3>

                        <div id="sampah-items-container" class="space-y-4 mb-4">
                            <p id="empty-message" class="text-gray-500">Belum ada item sampah yang ditambahkan.</p>
                        </div>
                        <x-input-error :messages="$errors->get('sampah')" class="mt-2" />
                        
                        {{-- Total Estimasi Penjualan --}}
                        <div class="text-right font-bold text-xl mt-4 border-t pt-4">
                            <span>Total Estimasi:</span>
                            <span id="total-estimasi">Rp 0</span>
                        </div>
                        
                        <div class="flex items-start space-x-2 border-t pt-4 mt-4">
                            <div class="flex-grow">
                                <select id="jenis_sampah_selector" class="border-gray-300 rounded-md shadow-sm w-full">
                                    <option value="">-- Pilih Jenis Sampah --</option>
                                    @foreach($jenisSampah as $sampah)
                                        {{-- PERUBAHAN: Menambahkan data-harga_jual --}}
                                        <option value="{{ $sampah->id }}" data-nama="{{ $sampah->nama_sampah }}" data-stok="{{ $sampah->stok }}" data-satuan="{{ $sampah->satuan }}" data-harga_jual="{{ $sampah->harga_jual }}">
                                            {{ $sampah->nama_sampah }} (Stok: {{ $sampah->stok }} {{ $sampah->satuan }})
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <x-primary-button type="button" id="add-item-btn" class="mt-0">Tambah</x-primary-button>
                        </div>

                        <div class="flex items-center justify-end mt-6 border-t pt-4">
                            <a href="{{ route('penjualan.index') }}" class="text-gray-600 hover:text-gray-900 mr-4">Batal</a>
                            <x-primary-button>
                                {{ __('Simpan Penjualan') }}
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
            const addItemBtn = document.getElementById('add-item-btn');
            const selector = document.getElementById('jenis_sampah_selector');
            const container = document.getElementById('sampah-items-container');
            const emptyMessage = document.getElementById('empty-message');
            const totalEstimasiEl = document.getElementById('total-estimasi');
            let itemIndex = 0;

            function updateTotalEstimasi() {
                let total = 0;
                container.querySelectorAll('.item-row').forEach(row => {
                    const jumlah = parseFloat(row.querySelector('input[type="number"]').value) || 0;
                    const harga = parseFloat(row.dataset.hargaJual) || 0;
                    const subtotal = jumlah * harga;
                    row.querySelector('.subtotal').textContent = 'Rp ' + new Intl.NumberFormat('id-ID').format(subtotal.toFixed(0));
                    total += subtotal;
                });
                totalEstimasiEl.textContent = 'Rp ' + new Intl.NumberFormat('id-ID').format(total.toFixed(0));
            }

            addItemBtn.addEventListener('click', function() {
                const selectedOption = selector.options[selector.selectedIndex];
                if (!selectedOption.value) return;

                if (document.querySelector(`#item-row-${selectedOption.value}`)) {
                    alert('Jenis sampah ini sudah ditambahkan.');
                    return;
                }

                if (emptyMessage) emptyMessage.style.display = 'none';

                const hargaJual = selectedOption.dataset.harga_jual;
                
                const itemHTML = `
                    <div class="item-row grid grid-cols-12 gap-4 items-center p-3 border rounded-md bg-gray-50" id="item-row-${selectedOption.value}" data-harga-jual="${hargaJual}">
                        <div class="col-span-12 md:col-span-4">
                            <span class="font-medium text-gray-800">${selectedOption.dataset.nama}</span>
                            <small class="block text-gray-500">Stok: ${selectedOption.dataset.stok} ${selectedOption.dataset.satuan} / @ Rp ${new Intl.NumberFormat('id-ID').format(hargaJual)}</small>
                        </div>
                        <div class="col-span-6 md:col-span-4">
                            <input type="hidden" name="sampah[${itemIndex}][id]" value="${selectedOption.value}">
                            <input type="number" step="0.01" min="0.01" max="${selectedOption.dataset.stok}" name="sampah[${itemIndex}][jumlah]" class="jumlah-input w-full border-gray-300 rounded-md shadow-sm text-sm" placeholder="Jumlah Dijual (${selectedOption.dataset.satuan})" required>
                        </div>
                        <div class="col-span-4 md:col-span-2">
                            <span class="subtotal font-semibold text-gray-700">Rp 0</span>
                        </div>
                        <div class="col-span-2 md:col-span-2 text-right">
                            <button type="button" class="text-red-500 hover:text-red-700 remove-item-btn text-sm font-semibold" data-id="${selectedOption.value}">Hapus</button>
                        </div>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', itemHTML);
                itemIndex++;
                selector.value = '';
                updateTotalEstimasi();
            });

            container.addEventListener('input', function(e) {
                if (e.target.classList.contains('jumlah-input')) {
                    updateTotalEstimasi();
                }
            });

            container.addEventListener('click', function(e) {
                if (e.target.classList.contains('remove-item-btn')) {
                    const id = e.target.dataset.id;
                    document.getElementById(`item-row-${id}`).remove();
                    
                    if (container.querySelectorAll('.item-row').length === 0) {
                        if (emptyMessage) emptyMessage.style.display = 'block';
                    }
                    updateTotalEstimasi();
                }
            });
        });
    </script>
    @endpush
</x-app-layout>