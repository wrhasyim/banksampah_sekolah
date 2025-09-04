<!DOCTYPE html>
<html>
<head>
    <title>Laporan Transaksi Per Kelas</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        h1, h2 { text-align: center; }
        h2 { margin-top: 30px; border-top: 1px solid #ccc; padding-top: 20px;}
        table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 10px; }
        th, td { border: 1px solid #000; padding: 6px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total-row { font-weight: bold; background-color: #e8e8e8; }
        .no-data { text-align: center; color: #888; }
        .page-break { page-break-after: always; }
    </style>
</head>
<body>
    <h1>Laporan Rekapitulasi Setoran Sampah</h1>

    @foreach ($dataLaporan as $dataKelas)
        <h2>Kelas: {{ $dataKelas['nama_kelas'] }}</h2>
        <table>
            <thead>
                <tr>
                    <th style="width: 20%;">Nama Siswa</th>
                    @foreach ($jenisSampahList as $jenisSampah)
                        <th style="text-align: center;">{{ $jenisSampah->nama_sampah }} ({{ $jenisSampah->satuan }})</th>
                    @endforeach
                </tr>
            </thead>
            <tbody>
                @forelse ($dataKelas['siswa'] as $dataSiswa)
                    <tr>
                        <td>{{ $dataSiswa['nama_siswa'] }}</td>
                        @foreach ($jenisSampahList as $jenisSampah)
                            @php
                                $jumlah = $dataSiswa['setoran'][$jenisSampah->id] ?? 0;
                            @endphp
                            <td style="text-align: center;">{{ $jumlah > 0 ? number_format($jumlah, 2, ',', '.') : '-' }}</td>
                        @endforeach
                    </tr>
                @empty
                    <tr>
                        <td colspan="{{ count($jenisSampahList) + 1 }}" class="no-data">Tidak ada data setoran di kelas ini.</td>
                    </tr>
                @endforelse
            </tbody>
            <tfoot>
                <tr class="total-row">
                    <td>TOTAL PER JENIS SAMPAH</td>
                    @foreach ($jenisSampahList as $jenisSampah)
                        @php
                            $total = $dataKelas['total_per_sampah'][$jenisSampah->id] ?? 0;
                        @endphp
                        <td style="text-align: center;">{{ number_format($total, 2, ',', '.') }}</td>
                    @endforeach
                </tr>
            </tfoot>
        </table>

        {{-- Hindari page break setelah item terakhir --}}
        @if (!$loop->last)
            <div class="page-break"></div>
        @endif
    @endforeach

</body>
</html>