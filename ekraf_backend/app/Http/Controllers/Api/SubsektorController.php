<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Subsektor;

class SubsektorController extends Controller
{
    public function getBySektor(Request $request)
    {
        $sektorId = $request->query('sektor_id');

        if (!$sektorId) {
            return response()->json(['error' => 'sektor_id is required'], 400);
        }

        $subsektors = Subsektor::where('sektor_id', $sektorId)->get();

        return response()->json($subsektors);
    }
}



// namespace App\Http\Controllers\Api;

// use App\Http\Controllers\Controller;
// use Illuminate\Http\Request;
// use App\Models\Subsektor;
// use App\Models\Pengusaha;

// class SubsektorController extends Controller
// {
//     // Get all subsektor by sektor_id (sudah ada)
//     public function getBySektor(Request $request)
//     {
//         $sektorId = $request->query('sektor_id');

//         if (!$sektorId) {
//             return response()->json(['error' => 'sektor_id is required'], 400);
//         }

//         $subsektors = Subsektor::where('sektor_id', $sektorId)->get();

//         return response()->json($subsektors);
//     }

//     // ✅ Get all pengusaha based on subsektor id
//     public function getPengusahaBySubsektor($id)
//     {
//         $subsektor = Subsektor::with('usaha.pengusaha')->find($id);

//         if (!$subsektor) {
//             return response()->json(['error' => 'Subsektor not found'], 404);
//         }

//         // Kumpulkan semua pengusaha dari semua usaha di subsektor
//         $pengusahaList = $subsektor->usaha->flatMap(function ($usaha) {
//             return $usaha->pengusaha;
//         });

//         return response()->json($pengusahaList);
//     }
// }