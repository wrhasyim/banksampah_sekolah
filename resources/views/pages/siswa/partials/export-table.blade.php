{{-- File: resources/views/pages/siswa/partials/export-table.blade.php --}}
<table>
    <thead>
        <tr>
            <th>No</th>
            <th>NIS</th>
            <th>Nama Siswa</th>
            <th>Kelas</th>
            <th>Saldo</th>
            <th>Setoran Terakhir</th>
        </tr>
    </thead>
    <tbody>
        @foreach($siswa as $key => $item)
            <tr>
                <td>{{ $key + 1 }}</td>
                <td>{{ $item->nis }}</td>
                <td>{{ $item->nama }}</td>
                <td>{{ $item->kelas->nama_kelas ?? 'N/A' }}</td>
                <td>{{ $item->saldo }}</td>
                <td>
                    {{-- Asumsi Anda punya relasi 'setoranTerakhir'
                         Jika tidak, kita akan tambahkan di Controller --}}
                    {{ $item->setoran_terakhir ? $item->setoran_terakhir->created_at->format('d/m/Y') : 'Belum Pernah' }}
                </td>
            </tr>
        @endforeach
    </tbody>
</table>