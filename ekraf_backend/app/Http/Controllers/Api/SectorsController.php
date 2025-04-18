<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Sector;

class SectorsController extends Controller
{
    public function index()
    {
        $sectors = Sector::limit(4)->get()->map(function ($item) {
            $item->icon_url = asset('storage/sectors/' . $item->icon_url);
            return $item;
        });

        return response()->json($sectors);
    }
}