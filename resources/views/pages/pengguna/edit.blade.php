<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
            {{ __('Edit Pengguna') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm dark:bg-gray-800 sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <form action="{{ route('pengguna.update', $pengguna->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        @include('pages.pengguna.partials.form-fields')
                        <div class="flex items-center justify-end mt-4">
                            <a href="{{ route('pengguna.index') }}" class="mr-4 text-sm font-medium text-gray-700 dark:text-gray-300 hover:underline">Batal</a>
                            <button type="submit" class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">Perbarui</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>