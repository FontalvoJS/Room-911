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
    Route::post('/create-employee', [AdminController::class, 'createEmployee'])->name('create-employee');
    Route::get('/get-employees', [AdminController::class, 'getEmployees'])->name('get-employees');
    Route::get('/get-departments', [AdminController::class, 'getDepartments'])->name('get-departments');
    Route::post('/delete-employee/{id}', [AdminController::class, 'deleteEmployee'])->name('delete-employee');
    Route::post('/update-employee/{id}', [AdminController::class, 'updateEmployee'])->name('update-employee');
});
// END