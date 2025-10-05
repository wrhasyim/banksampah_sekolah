<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.bootstrap5.css" rel="stylesheet">
        @vite(['resources/css/app.css', 'resources/js/app.js'])
        {{-- CSS untuk Toastr (Notifikasi) --}}
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script>
        // FUNGSI PENCARIAN SISWA TERPUSAT (ANTI-GAGAL)
        function initializeSiswaSelect2(selector, valueField) {
            $(selector).select2({
                placeholder: "Ketik nama siswa untuk mencari...",
                minimumInputLength: 2,
                ajax: {
                    url: "{{ route('select.siswa') }}",
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return { search: params.term };
                    },
                    processResults: function (data) {
                        return {
                            results: $.map(data, function(item) {
                                return {
                                    // 'id' untuk Select2 akan diisi oleh 'user_id' atau 'id' secara dinamis
                                    id: item[valueField],
                                    text: item.text
                                }
                            })
                        };
                    },
                    cache: true
                }
            });
        }
    </script>
<script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
    @stack('scripts')
        
    </body>
</html>