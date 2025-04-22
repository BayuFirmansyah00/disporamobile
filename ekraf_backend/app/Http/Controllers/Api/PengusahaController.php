<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pengusaha;

class PengusahaController extends Controller
{
    public function detailInformasiUsaha($pengusahaId)
    {
        $pengusaha = Pengusaha::with(['usaha.produk'])->findOrFail($pengusahaId);
        $usaha = $pengusaha->usaha;

        return response()->json([
            'pengusaha_nama' => $pengusaha->nama,
            'pengusaha_foto' => asset('storage/pengusaha/' . $pengusaha->foto_url),
            'no_hp' => $usaha->no_hp,
            'alamat' => $usaha->alamat,
            'galeri' => $usaha->produk->pluck('foto_url')->map(function ($url) {
                return asset('storage/produk/' . $url);
            }),
            'produk' => $usaha->produk->map(function ($produk) {
                return [
                    'nama' => $produk->nama,
                    'informasi' => $produk->informasi,
                    'harga' => $produk->harga,
                    'foto_url' => asset('storage/produk/' . $produk->foto_url),
                ];
            })
        ]);
    }
}