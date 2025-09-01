<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penjualan;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ChartController extends Controller
{
    public function getChartData(Request $request)
    {
        $type = $request->input('type', 'transaksi');
        $period = $request->input('period', 'monthly');

        switch ($type) {
            case 'sampah':
                return $this->getSampahChartData($period);
            case 'transaksi':
            default:
                return $this->getTransaksiChartData($period);
        }
    }

    private function getTransaksiChartData($period)
    {
        // Logika untuk data transaksi (setoran dan penjualan)
        $endDate = Carbon::now();
    $groupByFormat = 'Y-m-d';
    $labels = [];

    switch ($period) {
        case 'today':
            $startDate = Carbon::today();
            $groupByFormat = 'H:00';
            for ($i = 0; $i < 24; $i++) {
                $labels[] = str_pad($i, 2, '0', STR_PAD_LEFT) . ':00';
            }
            break;
        case '7d':
            $startDate = Carbon::now()->subDays(6);
            for ($i = 0; $i < 7; $i++) {
                $labels[] = $startDate->copy()->addDays($i)->format('D, M d');
            }
            break;
        case '30d':
            $startDate = Carbon::now()->subDays(29);
            for ($i = 0; $i < 30; $i++) {
                $labels[] = $startDate->copy()->addDays($i)->format('M d');
            }
            break;
        case 'monthly':
        default:
            $startDate = Carbon::now()->startOfYear();
            $endDate = Carbon::now()->endOfYear();
            $groupByFormat = 'Y-m';
            for ($i = 1; $i <= 12; $i++) {
                $labels[] = Carbon::create(null, $i, 1)->format('F');
            }
            break;
    }

    // Ambil data setoran
    $setoranQuery = Setoran::whereBetween('created_at', [$startDate, $endDate]);
    if ($period !== 'monthly') {
        $dataSetoran = $setoranQuery
            ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as date"), DB::raw('SUM(total_harga) as total'))
            ->groupBy('date')
            ->pluck('total', 'date');
    } else {
        $dataSetoran = $setoranQuery
            ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
            ->groupBy('month')
            ->pluck('total', 'month');
    }
    
    // Ambil data penjualan
    $penjualanQuery = Penjualan::whereBetween('created_at', [$startDate, $endDate]);
    if ($period !== 'monthly') {
         $dataPenjualan = $penjualanQuery
            ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as date"), DB::raw('SUM(total_harga) as total'))
            ->groupBy('date')
            ->pluck('total', 'date');
    } else {
        $dataPenjualan = $penjualanQuery
            ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
            ->groupBy('month')
            ->pluck('total', 'month');
    }

    $formattedSetoran = [];
    $formattedPenjualan = [];

    foreach ($labels as $label) {
        $key = '';
        if ($period === 'monthly') {
            $monthNum = Carbon::parse($label)->month;
            $key = Carbon::now()->year . '-' . str_pad($monthNum, 2, '0', STR_PAD_LEFT);
        } else {
            $key = Carbon::parse($label)->format('Y-m-d');
        }
        
        $formattedSetoran[] = $dataSetoran[$key] ?? 0;
        $formattedPenjualan[] = $dataPenjualan[$key] ?? 0;
    }

    return response()->json([
        'labels' => $labels,
        'dataSetoran' => $formattedSetoran,
        'dataPenjualan' => $formattedPenjualan,
    ]);
    }

    private function getSampahChartData($period)
    {
        // Logika untuk data jenis sampah
        $endDate = Carbon::now();

    switch ($period) {
        case 'today':
            $startDate = Carbon::today();
            break;
        case '7d':
            $startDate = Carbon::now()->subDays(6);
            break;
        case '30d':
            $startDate = Carbon::now()->subDays(29);
            break;
        case 'monthly':
        default:
            $startDate = Carbon::now()->startOfMonth();
            break;
    }

    $data = Setoran::join('jenis_sampah', 'setoran.id_jenis_sampah', '=', 'jenis_sampah.id')
        ->whereBetween('setoran.created_at', [$startDate, $endDate])
        ->select('jenis_sampah.nama_sampah', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
        ->groupBy('jenis_sampah.nama_sampah')
        ->orderBy('total_jumlah', 'desc')
        ->get();

    $labels = $data->pluck('nama_sampah');
    $dataValues = $data->pluck('total_jumlah');

    return response()->json([
        'labels' => $labels,
        'data' => $dataValues,
    ]);
    }
}