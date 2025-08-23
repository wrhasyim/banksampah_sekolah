<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Import Data Setoran Sampah') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <p class="text-sm text-gray-600 mb-4">
    Unggah file Excel (.xlsx atau .xls) yang berisi data setoran. Pastikan kolom-kolomnya sesuai dengan urutan: 
    **nisn, jenis_sampah, jumlah, tanggal**.
    <br>Anda bisa mengunduh contoh template di sini: 
    <a href="{{ route('setoran.export.sample') }}" class="text-blue-600 hover:underline">Download Template</a>
</p>
                    <form action="{{ route('setoran.import') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <div class="mb-4">
                            <label for="file" class="block text-sm font-medium text-gray-700">Pilih File Excel (.xlsx)</label>
                            <input type="file" name="file" id="file" required class="mt-1 block w-full">
                            @error('file')
                                <span class="text-red-500 text-sm">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="mt-4">
                            <x-primary-button type="submit">Import</x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>