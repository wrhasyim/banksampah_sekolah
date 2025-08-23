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
                    <p class="mb-4">
                        Unggah file Excel (.xlsx) yang berisi data setoran. Kolom harus sesuai urutan: **nama**, **kelas**, **jenis_sampah**, **jumlah**.
                        <br>
                        <a href="{{ route('setoran.export.sample') }}" class="text-blue-600 hover:underline">Unduh contoh template</a>
                    </p>
                    <form action="{{ route('setoran.import') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <div class="mb-4">
                            <x-input-label for="file" value="Pilih File Excel (.xlsx)" />
                            <x-text-input type="file" name="file" id="file" required class="mt-1 block w-full"/>
                            <x-input-error :messages="$errors->get('file')" class="mt-2" />
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