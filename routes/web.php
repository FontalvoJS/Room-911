<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controllers\AdminController;

// REDIRECT TO LOGIN
Route::get('/', function () {
    return Redirect::route('verify-user');
});
Route::get('/verify-user', function () {
    return Redirect::route('login');
})->name('verify-user');
// END

// AUTH ROUTES
Auth::routes();
// END

// WEB ROUTES
Route::group(['middleware' => 'auth'], function () {
    Route::get('/dashboard', [AdminController::class, 'index'])->name('dashboard');
    Route::post('/create-admin', [AdminController::class, 'createAdmin'])->name('create-admin');
});
// END