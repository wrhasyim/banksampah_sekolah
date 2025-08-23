<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Import Data Siswa') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <p class="mb-4">
                        Unggah file Excel (.xlsx) yang berisi data siswa. Kolom harus sesuai urutan: **nama_lengkap**, **username**, **password**, **nis**, **kelas**.
                        <br>
                        <a href="{{ route('siswa.export.sample') }}" class="text-blue-600 hover:underline">Unduh contoh template</a>
                    </p>

                    @if (session('import_errors'))
                        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                            <strong class="font-bold">Gagal mengimpor data!</strong>
                            <span class="block sm:inline">Ada beberapa kesalahan validasi.</span>
                            <ul class="mt-3 list-disc list-inside">
                                @foreach (session('import_errors') as $failure)
                                    <li>Baris {{ $failure->row() }}: {{ implode(', ', $failure->errors()) }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form action="{{ route('siswa.import') }}" method="POST" enctype="multipart/form-data">
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