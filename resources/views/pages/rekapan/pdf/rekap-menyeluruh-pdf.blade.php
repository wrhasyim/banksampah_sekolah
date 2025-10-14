<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Rekapitulasi Menyeluruh</title>
    <style>
        body {
            font-family: 'Helvetica', 'Arial', sans-serif;
            font-size: 12px; /* Ukuran font dasar diperbesar */
            color: #333;
        }
        @page { margin: 40px 25px; }
        .header { text-align: center; margin-bottom: 25px; border-bottom: 2px solid #333; padding-bottom: 15px; }
        .header h1 { margin: 0; font-size: 24px; color: #222; }
        .header p { margin: 2px 0; font-size: 14px; }
        .section-title { font-size: 18px; font-weight: bold; color: #333; margin-top: 25px; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px; }
        
        .summary-table { width: 100%; border-spacing: 10px; margin-bottom: 25px; }
        .summary-card { border: 1px solid #e2e8f0; border-radius: 8px; text-align: center; padding: 15px 10px; vertical-align: top; }
        .summary-card h3 { margin: 0 0 5px 0; font-size: 14px; font-weight: normal; color: #555; }
        .summary-card p { margin: 0; font-size: 20px; font-weight: bold; }
        
        .green { color: #2f855a; }
        .red { color: #c53030; }
        .blue { color: #2b6cb0; }
        
        table { width: 100%; border-collapse: collapse; margin-bottom: 25px; }
        th, td { padding: 8px 10px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        thead th { background-color: #edf2f7; font-size: 12px; text-transform: uppercase; font-weight: bold; border-bottom: 2px solid #cbd5e0; }
        tbody tr:nth-child(even) { background-color: #f7fafc; }
        tfoot td { font-weight: bold; background-color: #edf2f7; }
        .table-container { margin-bottom: 20px; }
        
        ul { list-style: none; padding: 0; margin: 0; border: 1px solid #e2e8f0; border-radius: 8px; }
        ul li { padding: 10px 15px; border-bottom: 1px solid #e2e8f0; }
        ul li:last-child { border-bottom: none; }
        ul li span { display: block; }
        ul li span:last-child { font-weight: bold; }
        
        .footer { position: fixed; bottom: -20px; left: 0; right: 0; text-align: center; font-size: 10px; color: #777; }
        .page-number:before { content: "Halaman " counter(page); }
    </style>
</head>
<body>

    <div class="footer">
        <span class="page-number"></span> | Laporan Dibuat pada {{ \Carbon\Carbon::now()->isoFormat('D MMMM YYYY, HH:mm') }}
    </div>

    <div class="header">
        <h1>Rekapitulasi Keuangan Menyeluruh</h1>
        <p>Bank Sampah Sekolah</p>
        <p>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</p>
    </div>

    <table class="summary-table" style="border: none;">
        <tr>
            <td class="summary-card" style="width: 33.33%;">
                <h3>Total Penjualan</h3>
                <p class="green">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</p>
            </td>
            <td class="summary-card" style="width: 33.33%;">
                <h3>Estimasi Kas Saat Ini</h3>
                <p class="blue">Rp {{ number_format($kas, 0, ',', '.') }}</p>
            </td>
            <td class="summary-card" style="width: 33.33%;">
                <h3>Total Pengeluaran Riil</h3>
                <p class="red">Rp {{ number_format($totalPengeluaranRiil, 0, ',', '.') }}</p>
            </td>
        </tr>
    </table>

    <div class="section-title">Rekap Pemasukan</div>
    <div class="table-container">@include('pages.rekapan.partials.tabel-setoran-siswa')</div>
    <div class="table-container">@include('pages.rekapan.partials.tabel-setoran-guru')</div>

    <div class="section-title">Rekap Pengeluaran & Tunggakan</div>
    <div class="table-container">@include('pages.rekapan.partials.rekap-pengeluaran-riil')</div>
    <div class="table-container">@include('pages.rekapan.partials.tunggakan-insentif-walas')</div>

</body>
</html>