<!DOCTYPE html>
<html>
<head>
    <title>Laporan Laba Rugi</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 60%; border-collapse: collapse; margin: auto; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f2f2f2; text-align: left;}
        .total { font-weight: bold; }
        .laba { color: green; }
        .rugi { color: red; }
        h1 { text-align: center; }
        p { text-align: center; margin-bottom: 20px;}
    </style>
</head>
<body>
    <h1>Laporan Laba Rugi</h1>
    <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d M Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d M Y') }}</p>

    <table>
        <tr>
            <th>Pendapatan</th>
            <td>Rp {{ number_format($pendapatan, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <th>Beban Operasional</th>
            <td>Rp {{ number_format($beban, 0, ',', '.') }}</td>
        </tr>
        <tr class="total">
            <th>Laba / Rugi Bersih</th>
            <td class="{{ $labaRugi >= 0 ? 'laba' : 'rugi' }}">
                Rp {{ number_format($labaRugi, 0, ',', '.') }}
            </td>
        </tr>
    </table>
</body>
</html>