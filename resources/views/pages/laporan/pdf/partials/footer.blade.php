<div class="summary-container">
    <h2 class="section-title">Rekapitulasi Total</h2>
    <table class="summary-table">
        <thead>
            <tr>
                <th>Jenis Sampah</th>
                <th>Total (Pcs)</th>
                <th>Total Harga (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($rekapJenisSampah as $rekap)
                <tr>
                    <td>{{ $rekap->nama_sampah }}</td>
                    <td class="text-right">{{ number_format($rekap->total_berat, 0, ',', '.') }}</td>
                    <td class="text-right">{{ number_format($rekap->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                 <tr>
                    <td colspan="3" class="no-data">Tidak ada rekapitulasi sampah.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <table class="totals-table">
        <tr>
            <td style="width: 70%;">TOTAL KESELURUHAN SETORAN (DEBIT)</td>
            <td class="text-right" style="width: 30%;">
                Rp {{ number_format($totalSetoran, 0, ',', '.') }}
            </td>
        </tr>
        <tr>
            <td>TOTAL KESELURUHAN PENARIKAN (KREDIT)</td>
            <td class="text-right">
                Rp {{ number_format($totalPenarikan, 0, ',', '.') }}
            </td>
        </tr>
    </table>
</div>
</body>
</html>