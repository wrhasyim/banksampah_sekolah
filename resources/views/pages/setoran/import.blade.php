<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Impor Data Setoran') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <div class="md:col-span-1">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium mb-4">Unggah File Excel</h3>
                        
                        @if ($errors->any())
                            <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
                                <strong class="font-bold">Oops! Terjadi kesalahan.</strong>
                                <ul class="mt-2 list-disc list-inside text-sm">
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        
                        @if (session('success'))
                             <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative">
                                {{ session('success') }}
                            </div>
                        @endif

                        <form action="{{ route('setoran.import') }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            <div>
                                <label for="file" class="block text-sm font-medium text-gray-700">Pilih file (.xlsx, .xls)</label>
                                <input type="file" name="file" id="file" class="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100" required>
                            </div>
                            <div class="mt-6 flex items-center justify-between">
                                <x-primary-button>
                                    {{ __('Impor Data') }}
                                </x-primary-button>
                                <a href="{{ route('setoran.export.sample') }}" class="text-sm text-gray-600 hover:text-gray-900 underline">
                                    Download Contoh
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="md:col-span-1">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                        <h3 class="text-lg font-medium mb-4">📝 Daftar Referensi untuk Excel</h3>
                        <p class="text-sm text-gray-600 mb-4">
                            Pastikan penulisan **Nama Siswa, Kelas, dan Nama Sampah** di file Excel Anda sama persis dengan tabel di bawah ini.
                        </p>
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg" style="max-height: 400px;">
                            <table class="w-full text-sm text-left text-gray-500">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
                                    <tr>
                                        <th class="px-6 py-3">Nama Siswa</th>
                                        <th class="px-6 py-3">Nama Kelas</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y">
                                    @forelse ($siswa as $item)
                                    <tr>
                                        <td class="px-6 py-4">{{ $item->pengguna->nama_lengkap }}</td>
                                        <td class="px-6 py-4">{{ $item->kelas->nama_kelas }}</td>
                                    </tr>
                                    @empty
                                    <tr><td colspan="2" class="px-6 py-4 text-center">Data siswa kosong.</td></tr>
                                    @endforelse
                                </tbody>
                            </table>
                             <table class="w-full text-sm text-left text-gray-500 mt-4">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
                                    <tr>
                                        <th class="px-6 py-3">Nama Sampah</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y">
                                    @forelse ($jenisSampah as $item)
                                    <tr>
                                        <td class="px-6 py-4">{{ $item->nama_sampah }}</td>
                                    </tr>
                                    @empty
                                    <tr><td class="px-6 py-4 text-center">Data jenis sampah kosong.</td></tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>