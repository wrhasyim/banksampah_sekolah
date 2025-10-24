{{-- File: resources/views/pages/siswa/export-pdf.blade.php --}}
<!DOCTYPE html>
<html>
<head>
    <title>Laporan Siswa Tidak Aktif</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        h1 { font-size: 16pt; text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #000; padding: 8px; text-align: left; font-size: 10pt; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Laporan Siswa Tidak Aktif</h1>
    <p>Filter: {{ $filterText }}</p>

    @include('pages.siswa.partials.export-table', ['siswa' => $siswa])

</body>
</html>