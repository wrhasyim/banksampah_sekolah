<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Impor Data Siswa') }}
        </h2>
        <p class="mt-1 text-sm text-gray-600">
            Halaman ini digunakan untuk menambahkan data siswa secara massal melalui file Excel.
        </p>
    </x-slot>

    <div class="py-12">
        <div class="max-w-3xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-medium mb-4">Unggah File Excel</h3>

                    {{-- Notifikasi sukses --}}
                    @if (session('success'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                            <span class="font-medium">Berhasil!</span> {{ session('success') }}
                        </div>
                    @endif

                    {{-- Notifikasi error --}}
                    @if ($errors->any())
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
                            <strong class="block font-medium mb-1">Terjadi kesalahan:</strong>
                            <ul class="list-disc list-inside text-sm">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    {{-- Notifikasi error dari session 'error' --}}
                    @if (session('error'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
                            <span class="font-medium">Kesalahan Impor:</span> {{ session('error') }}
                        </div>
                    @endif

                    {{-- Form Upload --}}
                    <form action="{{ route('siswa.import') }}" method="POST" enctype="multipart/form-data" class="space-y-6">
                        @csrf
                        <div>
                            <label for="file" class="block text-sm font-medium text-gray-700">Pilih file Excel</label>
                            <input 
                                type="file" 
                                name="file" 
                                id="file" 
                                accept=".xlsx,.xls" 
                                class="mt-1 block w-full text-sm text-gray-500 
                                       file:mr-4 file:py-2 file:px-4 
                                       file:rounded-md file:border-0 
                                       file:text-sm file:font-semibold 
                                       file:bg-gray-100 file:text-gray-700 
                                       hover:file:bg-gray-200" 
                                required>
                            <p class="mt-1 text-xs text-gray-500">Format yang didukung: .xlsx, .xls</p>
                        </div>

                        <div class="flex items-center justify-between">
                            <x-primary-button class="bg-green-600 hover:bg-green-700">
                                {{ __('Impor Data') }}
                            </x-primary-button>

                            <a href="{{ route('siswa.export.sample') }}" class="text-sm text-gray-600 hover:text-gray-900 underline">
                                Download Template Contoh
                            </a>
                        </div>
                    </form>

                    {{-- Tombol kembali --}}
                    <div class="mt-6">
                        <a href="{{ route('siswa.index') }}" class="inline-block text-sm px-4 py-2 bg-gray-100 text-gray-700 rounded-md hover:bg-gray-200">
                            ← Kembali ke Data Siswa
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>