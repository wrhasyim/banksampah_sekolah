<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Pengaturan Website') }}</h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            {{-- Card untuk Pengaturan Website & Honor --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                <div class="p-6 text-gray-900">
                    <h3 class="font-semibold text-lg mb-4">Pengaturan Umum & Honor</h3>

                    {{-- Menampilkan notifikasi Toastr --}}
                    @if (session('toastr-success'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded" role="alert">
                            {{ session('toastr-success') }}
                        </div>
                    @endif
                    @if (session('toastr-error'))
                         <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded" role="alert">
                            {{ session('toastr-error') }}
                        </div>
                    @endif

                    <form action="{{ route('settings.update') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        {{-- Pengaturan Umum --}}
                        <div>
                            <x-input-label for="site_title" value="Judul Website" />
                            <x-text-input id="site_title" class="block mt-1 w-full" type="text" name="site_title" :value="old('site_title', $settings['site_title'] ?? config('app.name'))" required />
                        </div>

                        <div class="mt-4">
                            <x-input-label for="site_favicon" value="Icon Website (Favicon)" />
                            <input id="site_favicon" class="block mt-1 w-full text-sm" type="file" name="site_favicon" />
                            @if(isset($settings['site_favicon']))
                                <div class="mt-2">
                                    <img src="{{ asset($settings['site_favicon']) }}" alt="Favicon saat ini" class="h-8 w-8">
                                    <p class="text-xs text-gray-500">Icon saat ini</p>
                                </div>
                            @endif
                        </div>

                        {{-- Pengaturan Honor --}}
                        <hr class="my-6">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <x-input-label for="persentase_pengelola" value="Persentase Pengelola (%)" />
                                <x-text-input id="persentase_pengelola" class="block mt-1 w-full" type="number" name="persentase_pengelola" :value="old('persentase_pengelola', $settings['persentase_pengelola'] ?? 0)" required />
                            </div>
                            <div>
                                <x-input-label for="persentase_wali_kelas" value="Persentase Wali Kelas (%)" />
                                <x-text-input id="persentase_wali_kelas" class="block mt-1 w-full" type="number" name="persentase_wali_kelas" :value="old('persentase_wali_kelas', $settings['persentase_wali_kelas'] ?? 0)" required />
                            </div>
                            <div>
                                <x-input-label for="persentase_sekolah" value="Persentase Sekolah (%)" />
                                <x-text-input id="persentase_sekolah" class="block mt-1 w-full" type="number" name="persentase_sekolah" :value="old('persentase_sekolah', $settings['persentase_sekolah'] ?? 0)" required />
                            </div>
                        </div>


                        <div class="flex items-center justify-end mt-6">
                            <x-primary-button>{{ __('Simpan Pengaturan') }}</x-primary-button>
                        </div>
                    </form>
                </div>
            </div>

            {{-- Card baru untuk Backup & Restore --}}
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="font-semibold text-lg mb-4">Backup & Restore Database</h3>

                     @if ($errors->has('backup_file'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded" role="alert">
                           {{ $errors->first('backup_file') }}
                        </div>
                    @endif

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        {{-- Kolom Backup --}}
                        <div>
                            <h4 class="font-semibold">Backup</h4>
                            <p class="text-sm text-gray-600 mb-2">Buat cadangan database Anda. File akan diunduh secara otomatis setelah proses selesai.</p>
                            <form action="{{ route('settings.backup') }}" method="POST">
                                @csrf
                                <x-primary-button type="submit">{{ __('Backup Database') }}</x-primary-button>
                            </form>
                        </div>

                        {{-- Kolom Restore --}}
                        <div>
                            <h4 class="font-semibold">Restore</h4>
                            <p class="text-sm text-gray-600 mb-2">Pulihkan database dari file backup. Pastikan file backup yang diunggah adalah file yang valid.</p>
                            <form action="{{ route('settings.restore') }}" method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="flex items-center">
                                     <input id="backup_file" class="block w-full text-sm" type="file" name="backup_file" required />
                                    <x-primary-button class="ml-4">{{ __('Restore Database') }}</x-primary-button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>