<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Laba Rugi</title>
    <style>
        body {
            font-family: 'sans-serif';
            font-size: 12px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 18px;
        }
        .header p {
            margin: 0;
            font-size: 14px;
        }
        .content table {
            width: 100%;
            border-collapse: collapse;
        }
        .content th, .content td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        .content .label {
            font-weight: bold;
        }
        .content .total {
            font-weight: bold;
            background-color: #f2f2f2;
        }
        .text-right {
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Laporan Laba Rugi</h1>
        <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d F Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d F Y') }}</p>
    </div>

    <div class="content">
        <table>
            <tr>
                <td class="label">Total Penjualan (Pendapatan)</td>
                {{-- PERBAIKAN: Mengganti $pendapatan menjadi $totalPenjualan --}}
                <td class="text-right">Rp. {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td class="label">Total Insentif Terbayar</td>
                <td class="text-right">Rp. {{ number_format($totalInsentif, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td class="label">Pengeluaran Lainnya (dari Buku Kas)</td>
                <td class="text-right">Rp. {{ number_format($pengeluaranLain, 0, ',', '.') }}</td>
            </tr>
            <tr class="total">
                <td class="label">Laba / Rugi Bersih</td>
                <td class="text-right">Rp. {{ number_format($labaRugi, 0, ',', '.') }}</td>
            </tr>
        </table>
    </div>

</body>
</html>