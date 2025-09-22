<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Laba Rugi</title>
    <style>
        /* Menggunakan font yang lebih modern dan mudah dibaca */
        body { 
            font-family: 'DejaVu Sans', 'Helvetica', 'Arial', sans-serif; 
            color: #333;
            font-size: 11px;
        }
        @page {
            margin: 45px;
        }
        .container {
            width: 100%;
        }
        .header {
            text-align: center;
            margin-bottom: 25px;
            border-bottom: 3px solid #4A90E2;
            padding-bottom: 15px;
        }
        .header h1 {
            margin: 0;
            font-size: 22px;
            color: #4A90E2;
        }
        .header h3 {
            margin: 5px 0 0;
            font-size: 14px;
            font-weight: normal;
            color: #555;
        }
        .report-table {
            width: 100%;
            border-collapse: collapse;
        }
        .report-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eaeaea;
        }
        /* Style untuk baris item, menggunakan indentasi */
        .report-table .item-row td:first-child {
            padding-left: 30px;
        }
        .report-table .amount {
            text-align: right;
        }
        /* Header untuk setiap seksi (Pendapatan/Pengeluaran) */
        .section-header {
            font-weight: bold;
            font-size: 14px;
            background-color: #f7faff;
            color: #4A90E2;
        }
        /* Baris untuk subtotal */
        .subtotal-row {
            font-weight: bold;
            background-color: #f7f7f7;
            border-top: 2px solid #ddd;
        }
        /* Baris untuk hasil akhir (Laba/Rugi) */
        .final-total-row {
            font-weight: bold;
            font-size: 16px;
            border-top: 3px solid #4A90E2;
            border-bottom: 3px solid #4A90E2;
        }
        /* Pewarnaan untuk laba (hijau) dan rugi (merah) */
        .profit {
            color: #28a745;
        }
        .loss {
            color: #dc3545;
        }
        .footer {
            position: fixed;
            bottom: -20px;
            left: 0;
            right: 0;
            text-align: center;
            font-size: 9px;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Laporan Laba Rugi</h1>
            <h3>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h3>
        </div>

        <table class="report-table">
            <tbody>
                <tr class="section-header">
                    <td>Pendapatan</td>
                    <td class="amount"></td>
                </tr>
                <tr class="item-row">
                    <td>Total Penjualan Sampah</td>
                    <td class="amount">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
                </tr>
                <tr class="subtotal-row">
                    <td>Total Pendapatan</td>
                    <td class="amount">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
                </tr>

                <tr class="section-header">
                    <td>Pengeluaran</td>
                    <td class="amount"></td>
                </tr>
                <tr class="item-row">
                    <td>Total Insentif Terbayar</td>
                    <td class="amount">Rp {{ number_format($totalInsentif, 0, ',', '.') }}</td>
                </tr>
                <tr class="item-row">
                    <td>Pengeluaran Lainnya (dari Buku Kas)</td>
                    <td class="amount">Rp {{ number_format($pengeluaranLain, 0, ',', '.') }}</td>
                </tr>
                @php
                    $totalPengeluaran = $totalInsentif + $pengeluaranLain;
                @endphp
                <tr class="subtotal-row">
                    <td>Total Pengeluaran</td>
                    <td class="amount">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</td>
                </tr>

                <tr class="final-total-row">
                    <td>LABA / RUGI BERSIH</td>
                    <td class="amount {{ $labaRugi >= 0 ? 'profit' : 'loss' }}">
                        Rp {{ number_format($labaRugi, 0, ',', '.') }}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="footer">
        Dicetak pada: {{ \Carbon\Carbon::now()->isoFormat('D MMMM YYYY, HH:mm') }} - Bank Sampah Sekolah
    </div>
</body>
</html>