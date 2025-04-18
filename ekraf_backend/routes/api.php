<?php
use App\Http\Controllers\Api\SectorsController;
use App\Http\Controllers\Api\EventController;
use App\Http\Controllers\Api\NewEventController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Route::get('/sectors', [SectorsController::class, 'index']);

Route::get('/events', [EventController::class, 'index']);

Route::get('/new_events', [NewEventController::class, 'index']);