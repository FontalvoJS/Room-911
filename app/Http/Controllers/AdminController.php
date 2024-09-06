<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;

class AdminController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        return view('dashboard');
    }
    public function createAdmin(Request $request)
    {
        $errorMessages = [
            'name.required' => 'Name is required',
            'email.required' => 'Email is required',
            'password.required' => 'Password is required',
            'isAdmin' => 'isAdmin is required',
        ];
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required',
            'password' => 'required',
            'isAdmin' => 'required',
        ], $errorMessages);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], Response::HTTP_BAD_REQUEST);
        }
        try {
            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => bcrypt($request->password),
            ]);
            return response()->json(['message' => 'New admin (' . $request->name . ') created successfully'], Response::HTTP_CREATED);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
