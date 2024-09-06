<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;

Route::get('/', function () {
    return Redirect::route('home');
});
Route::get('/home', function () {
    return Redirect::route('login');
})->name('home');
Auth::routes();
