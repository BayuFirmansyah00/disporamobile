<?php
use App\Http\Controllers\Api\SectorsController;
use App\Http\Controllers\Api\EventController;
use App\Http\Controllers\Api\NewEventController;
use App\Http\Controllers\Api\SubsektorController;
use App\Http\Controllers\Api\PengusahaController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Route::get('/sectors', [SectorsController::class, 'index']);

Route::get('/events', [EventController::class, 'index']);

Route::get('/new_events', [NewEventController::class, 'index']);

Route::get('/subsektor', [SubsektorController::class, 'getBySektor']);

// Route::get('/pengusaha', [PengusahaController::class, 'index']);

// Pelaku usaha berdasarkan subsektor
Route::get('/usaha-by-subsektor', [App\Http\Controllers\Api\UsahaController::class, 'getBySubsektor']);

// Detail usaha dari pengusaha
Route::get('/informasi-usaha/{pengusahaId}', [App\Http\Controllers\Api\PengusahaController::class, 'detailInformasiUsaha']);
