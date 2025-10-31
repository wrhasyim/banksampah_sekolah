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
                    {{-- 
                      PERBAIKAN DI SINI:
                      Mengubah 'setoran_terakhir' menjadi 'setoranTerakhir' (camelCase)
                      agar sesuai dengan nama relasi di Model.
                    --}}
                    **{{ $item->setoranTerakhir ? $item->setoranTerakhir->created_at->format('d/m/Y') : 'Belum Pernah' }}**
                </td>
            </tr>
        @endforeach
    </tbody>
</table>