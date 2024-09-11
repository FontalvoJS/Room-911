<?php

namespace App\Http\Controllers;

use App\Models\AccessAttempts;
use App\Models\Employees;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class Room911Controller extends Controller
{

    public function index($id)
    {
        return view('room_login', ['id' => $id]);
    }
    public function login(Request $request)
    {
        $errorMessages = [
            'required' => 'The :attribute field is required.',
            'min' => 'The :attribute must be at least :min characters.',
        ];
        $request->validate([
            'employee_id' => 'required|string|min:10',
        ], $errorMessages);
        try {
            $employee = Employees::select('has_access')->where('employee_id', $request->employee_id)->first();
            if ($employee) {
                if ($employee->has_access == 1) {
                    AccessAttempts::create([
                        'employee_id' => $request->employee_id,
                        'ip' => $request->ip(),
                        'was_successful' => 1,
                        'attempted_at' => now(),
                    ]);
                    return response()->json(['message' => 'Access granted'], Response::HTTP_OK);
                } else {
                    AccessAttempts::create([
                        'employee_id' => $request->employee_id,
                        'ip' => $request->ip(),
                        'was_successful' => 0,
                        'attempted_at' => now(),
                    ]);
                    return response()->json(['error' => 'Access denied'], Response::HTTP_FORBIDDEN);
                }
            } else {
                AccessAttempts::create([
                    'employee_id' => $request->employee_id,
                    'ip' => $request->ip(),
                    'was_successful' => 0,
                    'attempted_at' => now(),
                ]);
                return response()->json(['error' => 'Employee not found'], Response::HTTP_FORBIDDEN);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
