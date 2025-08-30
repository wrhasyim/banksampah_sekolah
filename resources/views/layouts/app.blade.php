<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        @vite(['resources/css/app.css', 'resources/js/app.js'])

        {{-- CSS untuk Toastr (Notifikasi) --}}
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    </head>
    <body class="font-sans antialiased">
        <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
            @include('layouts.navigation')

            {{-- BAGIAN HEADER DIHAPUS DARI SINI --}}

            <main>
                {{ $slot }}
            </main>
        </div>

        {{-- jQuery (dibutuhkan oleh Toastr) --}}
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        {{-- JavaScript untuk Toastr --}}
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

        {{-- Skrip untuk Menampilkan Notifikasi dari Session --}}
        <script>
            toastr.options.positionClass = 'toast-bottom-right';
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