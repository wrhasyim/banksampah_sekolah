<?php

namespace App\Http\Controllers;

use App\Models\Insentif;
use Illuminate\Http\Request;

class InsentifController extends Controller
{
    public function index()
    {
        $insentifs = Insentif::with('penjualan', 'kelas.waliKelas')->latest()->get();
        return view('pages.insentif.index', compact('insentifs'));
    }
}