<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">{{ __('Pengaturan Website') }}</h2>
    </x-slot>
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if (session('status'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif
                    <form action="{{ route('settings.update') }}" method="POST" enctype="multipart/form-data">
                        @csrf
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
                        <div class="flex items-center justify-end mt-4">
                            <x-primary-button>{{ __('Simpan Pengaturan') }}</x-primary-button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>