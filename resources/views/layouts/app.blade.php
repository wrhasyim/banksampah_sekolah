<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ $siteSettings['site_title'] ?? config('app.name', 'Laravel') }}</title>

        @if(isset($siteSettings['site_favicon']))
            <link rel="icon" href="{{ asset($siteSettings['site_favicon']) }}" type="image/x-icon">
        @endif

        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

        @vite(['resources/css/app.css', 'resources/js/app.js'])
        @stack('styles')
    </head>
    <body class="font-sans antialiased">
        <div class="min-h-screen bg-gray-100">
            @include('layouts.navigation')

            @if (isset($header))
                <header class="bg-white shadow">
                    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                        {{ $header }}
                    </div>
                </header>
            @endif

            <main>
                {{ $slot }}
            </main>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        
        <script>
            // Atur posisi dan opsi notifikasi
            toastr.options = {
                "positionClass": "toast-bottom-right",
                "progressBar": true,
            };

            @if(session('toastr-success'))
                toastr.success("{{ session('toastr-success') }}");
            @endif

            @if(session('toastr-error'))
                toastr.error("{{ session('toastr-error') }}");
            @endif
        </script>

        @stack('scripts')
    </body>
</html>