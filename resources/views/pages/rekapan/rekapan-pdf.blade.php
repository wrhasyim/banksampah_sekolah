<!DOCTYPE html>
<html>
<head>
    <title>{{ $title }}</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        h1, h2 { text-align: center; }
    </style>
</head>
<body>
    <h1>{{ $title }}</h1>
    <p style="text-align: center;">Dicetak pada: {{ date('d-m-Y H:i') }}</p>

    <h2>Rekapan Terlambat</h2>
    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nama</th>
                <th>Kelas</th>
                <th>Jenis Sampah</th>
                <th>Total Harga</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($data['setoranTerlambat'] as $setoran)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($setoran->created_at)->format('d-m-Y') }}</td>
                    <td>{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                    <td>{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td>{{ $setoran->jenisSampah->nama_sampah }}</td>
                    <td>Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="5">Tidak ada data.</td></tr>
            @endforelse
        </tbody>
    </table>

    <h2>Rekapan Tanpa Wali Kelas</h2>
    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nama</th>
                <th>Kelas</th>
                <th>Jenis Sampah</th>
                <th>Total Harga</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($data['setoranTanpaWaliKelas'] as $setoran)
                 <tr>
                    <td>{{ \Carbon\Carbon::parse($setoran->created_at)->format('d-m-Y') }}</td>
                    <td>{{ $setoran->siswa->pengguna->nama_lengkap }}</td>
                    <td>{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td>{{ $setoran->jenisSampah->nama_sampah }}</td>
                    <td>Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="5">Tidak ada data.</td></tr>
            @endforelse
        </tbody>
    </table>
</body>
</html>