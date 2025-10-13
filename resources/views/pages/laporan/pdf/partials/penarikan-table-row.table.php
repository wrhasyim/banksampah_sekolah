<tr>
    <td class="text-center">{{ $loop->iteration }}</td>
    <td class="text-center">{{ \Carbon\Carbon::parse($item->tanggal_penarikan)->isoFormat('D MMM Y') }}</td>
    <td>{{ optional(optional($item->siswa)->pengguna)->nama_lengkap ?? 'N/A' }}</td>
    <td class="text-center">{{ optional(optional($item->siswa)->kelas)->nama_kelas ?? 'N/A' }}</td>
    <td class="text-right">{{ number_format($item->jumlah_penarikan, 0, ',', '.') }}</td>
</tr>