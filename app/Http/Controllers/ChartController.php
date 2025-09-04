<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penjualan;
use App\Models\JenisSampah;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ChartController extends Controller
{
    /**
     * Helper function untuk menentukan rentang tanggal berdasarkan periode.
     */
    private function getDateRange($period)
    {
        $now = Carbon::now();
        switch ($period) {
            case 'today':
                return [$now->copy()->startOfDay(), $now->copy()->endOfDay()];
            case '7d':
                return [$now->copy()->subDays(6)->startOfDay(), $now->copy()->endOfDay()];
            case '30d':
                return [$now->copy()->subDays(29)->startOfDay(), $now->copy()->endOfDay()];
            case 'monthly':
            default:
                return [$now->copy()->startOfMonth(), $now->copy()->endOfMonth()];
        }
    }

    /**
     * Helper function untuk menghasilkan label berdasarkan periode.
     */
    private function generateLabels($period, $startDate, $endDate)
    {
        $labels = [];
        if ($period === 'today') {
            for ($i = 0; $i < 24; $i++) {
                $labels[] = str_pad($i, 2, '0', STR_PAD_LEFT) . ':00';
            }
        } elseif ($period === '7d' || $period === '30d') {
            $currentDate = $startDate->copy();
            while ($currentDate <= $endDate) {
                $labels[] = $currentDate->format('d M');
                $currentDate->addDay();
            }
        } else { // monthly
            $daysInMonth = $endDate->day;
            for ($i = 1; $i <= $daysInMonth; $i++) {
                $labels[] = 'Tgl ' . $i;
            }
        }
        return $labels;
    }

    /**
     * Menyediakan data untuk grafik transaksi (Setoran dan Penjualan).
     */
    public function getTransaksiData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        [$startDate, $endDate] = $this->getDateRange($period);
        $labels = $this->generateLabels($period, $startDate, $endDate);
        
        $setoranData = array_fill(0, count($labels), 0);
        $penjualanData = array_fill(0, count($labels), 0);

        // --- Data Setoran ---
        $setoran = Setoran::whereBetween('created_at', [$startDate, $endDate])
            ->select(DB::raw('DATE(created_at) as tanggal'), DB::raw('HOUR(created_at) as jam'), DB::raw('SUM(total_harga) as total'))
            ->groupBy('tanggal', 'jam')
            ->get();

        foreach ($setoran as $item) {
            if ($period === 'today') {
                $index = (int)$item->jam;
                if(isset($setoranData[$index])) $setoranData[$index] += $item->total;
            } elseif ($period === '7d' || $period === '30d') {
                $label = Carbon::parse($item->tanggal)->format('d M');
                $index = array_search($label, $labels);
                if ($index !== false) $setoranData[$index] += $item->total;
            } else {
                $index = Carbon::parse($item->tanggal)->day - 1;
                if(isset($setoranData[$index])) $setoranData[$index] += $item->total;
            }
        }

        // --- Data Penjualan ---
        $penjualan = Penjualan::whereBetween('created_at', [$startDate, $endDate])
            ->select(DB::raw('DATE(created_at) as tanggal'), DB::raw('HOUR(created_at) as jam'), DB::raw('SUM(total_harga) as total'))
            ->groupBy('tanggal', 'jam')
            ->get();

        foreach ($penjualan as $item) {
             if ($period === 'today') {
                $index = (int)$item->jam;
                if(isset($penjualanData[$index])) $penjualanData[$index] += $item->total;
            } elseif ($period === '7d' || $period === '30d') {
                $label = Carbon::parse($item->tanggal)->format('d M');
                $index = array_search($label, $labels);
                if ($index !== false) $penjualanData[$index] += $item->total;
            } else {
                $index = Carbon::parse($item->tanggal)->day - 1;
                if(isset($penjualanData[$index])) $penjualanData[$index] += $item->total;
            }
        }

        return response()->json([
            'labels' => $labels,
            'dataSetoran' => $setoranData,
            'dataPenjualan' => $penjualanData,
        ]);
    }
    
    /**
     * Menyediakan data untuk grafik jenis sampah terkumpul.
     */
    public function getSampahData(Request $request)
{
    try {
        $period = $request->input('period', 'monthly');
        [$startDate, $endDate] = $this->getDateRange($period);

        $dataSampah = DB::table('setoran')
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
            ->whereBetween('setoran.created_at', [$startDate, $endDate])
            ->select('jenis_sampah.nama_sampah', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
            ->groupBy('jenis_sampah.nama_sampah')
            ->orderBy('total_jumlah', 'desc')
            ->get();

        return response()->json([
            'labels' => $dataSampah->pluck('nama_sampah')->toArray(),
            'data'   => $dataSampah->pluck('total_jumlah')->toArray(),
        ]);

    } catch (\Exception $e) {
        // Baris ini akan mencatat error detail ke dalam file log Laravel Anda
        \Illuminate\Support\Facades\Log::error('Gagal mengambil data chart sampah: ' . $e->getMessage());

        // Baris ini akan mengirim respon error 500 ke browser
        return response()->json([
            'error' => 'Terjadi kesalahan di server saat mengambil data sampah.',
            'message' => $e->getMessage() // Pesan error untuk debugging
        ], 500);
    }
}
}