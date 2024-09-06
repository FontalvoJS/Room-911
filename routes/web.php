<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controllers\HomeController;

Route::get('/', function () {
    return Redirect::route('verify-user');
});
Route::get('/verify-user', function () {
    return Redirect::route('login');
})->name('verify-user');

Route::get('/dashboard', [HomeController::class, 'index'])->name('dashboard');

Auth::routes();
