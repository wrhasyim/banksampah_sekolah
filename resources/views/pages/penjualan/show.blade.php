{{-- Ganti bagian <tbody> di dalam tabel --}}
<tbody>
    @foreach($penjualan->detailPenjualan as $detail)
    <tr class="bg-white border-b">
        <td class="px-6 py-4">{{ $detail->jenisSampah->nama_sampah }}</td>
        <td class="px-6 py-4 text-center">{{ $detail->jumlah }} {{ $detail->jenisSampah->satuan }}</td>
        <td class="px-6 py-4 text-right">Rp {{ number_format($detail->subtotal_harga, 0, ',', '.') }}</td>
    </tr>
    @endforeach
</tbody>