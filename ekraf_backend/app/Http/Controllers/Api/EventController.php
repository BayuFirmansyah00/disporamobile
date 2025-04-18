<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;

class EventController extends Controller
{
    public function index()
    {
        $events = Event::all()->map(function ($event) {
            $event->poster_url = asset('storage/events/' . $event->poster_url);
            return $event;
        });

        return response()->json($events);
    }
}