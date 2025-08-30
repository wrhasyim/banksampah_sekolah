<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Pengaturan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    
                    <form action="{{ route('settings.update') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        <h3 class="text-lg font-semibold border-b border-gray-200 dark:border-gray-700 pb-2 mb-4">Pengaturan Umum</h3>

                        <div>
                            <x-input-label for="site_title" value="Judul Website" />
                            <x-text-input id="site_title" class="block mt-1 w-full" type="text" name="site_title" :value="old('site_title', $settings['site_title'] ?? config('app.name'))" required />
                            <x-input-error :messages="$errors->get('site_title')" class="mt-2" />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="site_favicon" value="Icon Website (Favicon)" />
                            <input id="site_favicon" class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" type="file" name="site_favicon">
                            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">Gunakan file .ico, .png, atau .jpg.</p>
                            
                            @if(isset($settings['site_favicon']))
                                <div class="mt-2">
                                    <img src="{{ asset($settings['site_favicon']) }}" alt="Favicon saat ini" class="h-8 w-8">
                                    <p class="text-xs text-gray-500">Icon saat ini</p>
                                </div>
                            @endif
                            <x-input-error :messages="$errors->get('site_favicon')" class="mt-2" />
                        </div>

                        {{-- --- PENAMBAHAN: Pengaturan Honor --- --}}
                        <h3 class="text-lg font-semibold border-b border-gray-200 dark:border-gray-700 pb-2 mt-8 mb-4">Pengaturan Honor (dari Penjualan)</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">Atur persentase honor yang akan otomatis dicatat sebagai pengeluaran di Buku Kas setiap kali ada penjualan sampah. Total tidak boleh lebih dari 100%.</p>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <label for="persentase_pengelola" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Pengelola (%)</label>
                                <input type="number" step="0.01" id="persentase_pengelola" name="persentase_pengelola" value="{{ old('persentase_pengelola', $settings['persentase_pengelola'] ?? 0) }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" required>
                                <x-input-error :messages="$errors->get('persentase_pengelola')" class="mt-2" />
                            </div>

                            <div>
                                <label for="persentase_wali_kelas" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Wali Kelas (%)</label>
                                <input type="number" step="0.01" id="persentase_wali_kelas" name="persentase_wali_kelas" value="{{ old('persentase_wali_kelas', $settings['persentase_wali_kelas'] ?? 0) }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" required>
                                 <x-input-error :messages="$errors->get('persentase_wali_kelas')" class="mt-2" />
                            </div>

                            <div>
                                <label for="persentase_sekolah" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Sekolah (%)</label>
                                <input type="number" step="0.01" id="persentase_sekolah" name="persentase_sekolah" value="{{ old('persentase_sekolah', $settings['persentase_sekolah'] ?? 0) }}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" required>
                                 <x-input-error :messages="$errors->get('persentase_sekolah')" class="mt-2" />
                            </div>
                        </div>

                        <div class="flex items-center justify-end mt-6">
                            <x-primary-button>{{ __('Simpan Pengaturan') }}</x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>