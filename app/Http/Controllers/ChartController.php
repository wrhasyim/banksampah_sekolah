<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penjualan;
use Illuminate\Support\Facades\DB;

class ChartController extends Controller
{
    public function setoranPerBulan()
    {
        $data = Setoran::select(
            DB::raw('MONTH(created_at) as bulan'),
            DB::raw('SUM(total_harga) as total')
        )
        ->whereYear('created_at', date('Y'))
        ->groupBy('bulan')
        ->orderBy('bulan')
        ->get();

        return response()->json($data);
    }
    
    // Tambahkan method lain untuk data penjualan, dll.
}