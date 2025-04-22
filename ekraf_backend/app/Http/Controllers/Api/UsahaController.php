<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Usaha;

class UsahaController extends Controller
{
    public function getBySubsektor(Request $request)
    {
        $subsektorId = $request->query('subsektor_id');

        if (!$subsektorId) {
            return response()->json(['error' => 'subsektor_id is required'], 400);
        }

        $usahaList = Usaha::with(['pengusaha', 'sektor', 'subsektor'])
            ->where('subsektor_id', $subsektorId)
            ->get()
            ->map(function ($usaha) {
                return [
                    'nama_toko' => $usaha->nama_toko,
                    'logo_url' => asset('storage/usaha/' . $usaha->logo_url),
                    'sektor' => $usaha->sektor->nama ?? null,
                    'subsektor' => $usaha->subsektor->nama ?? null,
                    'pengusaha' => $usaha->pengusaha->map(function ($pengusaha) {
                        return [
                            'id' => $pengusaha->id,
                            'nama' => $pengusaha->nama,
                            'foto_url' => asset('storage/pengusaha/' . $pengusaha->foto_url),
                        ];
                    })->toArray() ?? [] // tambahkan .toArray() biar tetap array meskipun kosong
                ];
            });

        return response()->json($usahaList);
    }
}