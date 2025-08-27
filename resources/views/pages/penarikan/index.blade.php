<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Penarikan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">

                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <a href="{{ route('penarikan.create') }}"
                                class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-blue-700 border border-transparent rounded-md hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Tambah Penarikan (Per Siswa)
                            </a>
                            {{-- PERBAIKAN: Mengubah nama route agar sesuai --}}
                            <a href="{{ route('penarikan.create.kelas') }}"
                                class="inline-flex items-center px-4 py-2 ml-2 text-sm font-medium text-white bg-green-700 border border-transparent rounded-md hover:bg-green-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                Tambah Penarikan (Per Kelas)
                            </a>
                        </div>
                    </div>


                    <table class="min-w-full bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-700">
                            <tr>
                                <th scope="col"
                                    class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-400">
                                    No
                                ...
</x-app-layout>