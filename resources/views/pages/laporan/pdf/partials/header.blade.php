<!DOCTYPE html>
<html>
<head>
    <title>Laporan Transaksi</title>
    <style>
        body { font-family: 'sans-serif'; margin: 20px; font-size: 12px; }
        .header h1, .header h4 { text-align: center; margin: 5px 0; }
        .header h1 { font-size: 18px; }
        .header h4 { font-size: 14px; font-weight: normal; }
        .content-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .content-table th, .content-table td { border: 1px solid #000; padding: 6px; }
        .content-table th { background-color: #f2f2f2; text-align: center; }
        .content-table td.text-right { text-align: right; }
        .content-table td.text-center { text-align: center; }
        .section-title { font-size: 16px; margin-top: 30px; margin-bottom: 10px; text-align: center; }
        .summary-container { margin-top: 40px; page-break-inside: avoid; }
        .summary-table { width: 60%; margin: 20px auto 0 auto; border-collapse: collapse; }
        .summary-table th, .summary-table td { border: 1px solid #000; padding: 6px; }
        .summary-table th { background-color: #f2f2f2; text-align: center; }
        .totals-table { width: 60%; margin: 20px auto 0 auto; }
        .totals-table td { font-weight: bold; padding: 5px; }
        .no-data { text-align: center; color: #888; padding: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Laporan Transaksi (Setoran & Penarikan)</h1>
        <h4>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h4>
    </div>