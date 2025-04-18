<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;

class NewEventController extends Controller
{
    public function index()
    {
        $events = Event::latest()->take(3)->get()->map(function ($event) {
            $event->poster_url = asset('storage/events/' . $event->poster_url);
            return $event;
        });

        return response()->json($events);
    }
}