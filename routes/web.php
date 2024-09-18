<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\Room911Controller;

Route::get('/', function () {
    return Redirect::route('verify-user');
});
Route::get('/verify-user', function () {
    return Redirect::route('login');
})->name('verify-user');

Auth::routes();

Route::group(['middleware' => 'auth'], function () {
    Route::get('/dashboard', [AdminController::class, 'index'])->name('dashboard');

    // CREATE ADMIN AND EMPLOYEE
    Route::post('/create-admin', [AdminController::class, 'createAdmin'])->name('create-admin');
    Route::post('/create-employee', [AdminController::class, 'createEmployee'])->name('create-employee');

    // UPDATE EMPLOYEES
    Route::post('/update-employee/{id}', [AdminController::class, 'updateEmployee'])->name('update-employee');

    // FILE MANAGEMENT
    Route::post('/upload-file', [AdminController::class, 'uploadFile'])->name('upload-file');
    Route::post('/export-data', [AdminController::class, 'getAccessHistory'])->name('export-data');

    // GET DEPARTMENTS, USERS AND EMPLOYEES
    Route::get('/get-employees', [AdminController::class, 'getEmployees'])->name('get-employees');
    Route::get('/get-users', [AdminController::class, 'getUsers'])->name('get-users');
    Route::post('/get-employees-by-date', [AdminController::class, 'getEmployeesByDate'])->name('get-employees-by-date');
    Route::get('/get-departments', [AdminController::class, 'getDepartments'])->name('get-departments');

    // DELETE ADMIN AND EMPLOYEE
    Route::post('/delete-employee/{id}', [AdminController::class, 'deleteEmployee'])->name('delete-employee');
    Route::post('/delete-user/{id}', [AdminController::class, 'deleteUser'])->name('delete-user');

    // SIMULATION
    Route::get('/simulate-room/{id}', [Room911Controller::class, 'index'])->name('simulate-room');
    Route::post('/login-room', [Room911Controller::class, 'login'])->name('login-room');
});
