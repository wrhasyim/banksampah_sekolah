<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rekapitulasi Setoran Guru</title>
    <style>
        /* Pengaturan Font dan Halaman */
        @page {
            margin: 0cm; /* Menghilangkan margin bawaan */
        }
        body {
            font-family: 'Helvetica', sans-serif;
            font-size: 11px;
            color: #333;
            margin: 2.5cm 1.5cm 2cm 1.5cm; /* Atas, Kanan, Bawah, Kiri */
        }

        /* Header dan Footer */
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 2cm;
            padding: 0 1.5cm;
            border-bottom: 1px solid #ddd;
        }
        footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 1.5cm;
            text-align: center;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
        .school-info {
            float: left;
        }
        .school-logo {
            float: right;
            max-height: 50px; /* Sesuaikan ukuran logo */
        }

        /* Konten Utama */
        h1, h2, h3 {
            margin: 0;
            padding: 0;
        }
        h1 {
            font-size: 18px;
            color: #222;
        }
        h2 {
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }
        .report-title {
            text-align: center;
            margin-bottom: 25px;
        }
        .print-date {
            text-align: center;
            font-size: 9px;
            color: #777;
            margin-top: 5px;
        }

        /* Tabel */
        .table-wrapper {
            margin-bottom: 30px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden; /* Agar border-radius terlihat */
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        thead th {
            background-color: #f8fafc;
            color: #4a5568;
            font-weight: bold;
            font-size: 10px;
            text-transform: uppercase;
        }
        .total-row td {
            font-weight: bold;
            background-color: #f7fafc;
            color: #1a202c;
        }
        .total-amount {
            color: #2c5282; /* Warna biru untuk total */
        }
        .page-break {
            page-break-after: always;
        }
    </style>
</head>
<body>
    <header>
        {{-- Ganti dengan path logo sekolah Anda --}}
        {{-- <img src="{{ public_path('images/logo-sekolah.png') }}" alt="Logo Sekolah" class="school-logo"> --}}
        <div class="school-info">
            <h1 style="font-size:16px; font-weight:bold;">SMK TARUNA KARYA MANDIRI</h1>
            <p style="font-size:11px;">Jalan Alamat Sekolah No. 123, Kota, Provinsi</p>
        </div>
    </header>

    <footer>
        Rekapitulasi Setoran Guru Bank Sampah Sekolah | Dicetak pada: {{ date('d F Y') }}
    </footer>

    <main>
        <div class="report-title">
            <h1>Rekapitulasi Setoran Guru</h1>
            <p class="print-date">Periode sampai dengan {{ date('d F Y') }}</p>
        </div>

        @forelse ($rekapData as $guruId => $data)
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color: #e2e8f0;">
                                NAMA GURU: {{ strtoupper($data['nama_guru']) }}
                            </th>
                        </tr>
                        <tr>
                            <th>Jenis Sampah</th>
                            <th style="text-align: right;">Total Jumlah</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($data['sampah'] as $namaSampah => $detail)
                            <tr>
                                <td>{{ $namaSampah }}</td>
                                <td style="text-align: right;">{{ number_format($detail['jumlah'], 2, ',', '.') }} {{ $detail['satuan'] }}</td>
                            </tr>
                        @endforeach
                        <tr class="total-row">
                            <td><strong>Total Pendapatan</strong></td>
                            <td style="text-align: right;" class="total-amount">
                                <strong>Rp {{ number_format($data['total_harga'], 0, ',', '.') }}</strong>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            @if (!$loop->last)
                <div class="page-break"></div>
            @endif
        @empty
            <p style="text-align: center;">Tidak ada data setoran dari guru untuk direkapitulasi.</p>
        @endforelse
    </main>

</body>
</html>