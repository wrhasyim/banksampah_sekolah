{{-- File: resources/views/pages/rekapan/pdf/rekapan-terlambat-pdf.blade.php --}}
<!DOCTYPE html>
<html>
<head>
    <title>Rekapan Siswa Terlambat</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; font-size: 12px; }
        th { background-color: #f2f2f2; }
        h1 { text-align: center; }
    </style>
</head>
<body>
    <h1>Rekapan Siswa Terlambat</h1>
    <p style="text-align: center;">Dicetak pada: {{ date('d-m-Y H:i') }}</p>

    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nama Siswa</th>
                <th>Kelas</th>
                <th>Jenis Sampah</th>
                <th>Total Harga</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($data as $setoran)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($setoran->created_at)->format('d-m-Y') }}</td>
                    <td>{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                    <td>{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td>{{ $setoran->jenisSampah->nama_sampah }}</td>
                    <td>Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="5" style="text-align: center;">Tidak ada data.</td>
                </tr>
            @endforelse
        </tbody>
    </table>
</body>
</html>