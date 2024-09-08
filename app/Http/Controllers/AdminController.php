<?php

namespace App\Http\Controllers;

use App\Models\Departments;
use App\Models\Employees;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;
use Ramsey\Uuid\Uuid;

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

    public function createEmployee(Request $request)
    {
        $errorMessages = [
            'name.required' => 'Name is required',
            'lastname.required' => 'Last name is required',
            'department.required' => 'Department is required',
        ];

        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'lastname' => 'required',
            'department' => 'required',
        ], $errorMessages);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], Response::HTTP_BAD_REQUEST);
        }
        try {
            $uuid = Uuid::uuid4()->toString();
            $uuidWithoutmidline = str_replace('-', '', $uuid);
            Employees::create([
                'name' => $request->name,
                'last_name' => $request->lastname,
                'department' => $request->department,
                'employee_id' => strtoupper($uuidWithoutmidline),
                'has_access' => 1,
            ]);
            return response()->json(['message' => 'New employee (' . $request->name . ') created successfully'], Response::HTTP_CREATED);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getEmployees()
    {
        try {
            $employees = Employees::select('employees.id', 'employees.employee_id', 'employees.name', 'employees.last_name', 'departments.name as department', 'employees.has_access')
                ->join('departments', 'employees.department', '=', 'departments.id')
                ->get();
            return response()->json(['employees' => $employees], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getDepartments()
    {
        try {
            $departments = Departments::all();
            return response()->json(['departments' => $departments], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    public function deleteEmployee($id)
    {
        try {
            $employee = Employees::find($id);
            $employee->delete();
            return response()->json(['message' => 'Employee deleted successfully'], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function updateEmployee($id, Request $request)
    {
        try {
            $employee = Employees::find($id);

            if (!$employee) {
                return response()->json(['error' => 'Employee not found'], Response::HTTP_NOT_FOUND);
            }

            // Campos a verificar
            $fields = ['name', 'last_name', 'department', 'has_access'];
            $updatedFields = [];

            foreach ($fields as $field) {
                // Verificar si el campo está presente en la solicitud y si su valor es diferente al actual
                if ($request->has($field) && $employee->$field !== $request->$field) {
                    $employee->$field = $request->$field;
                    $updatedFields[] = $field;
                }
            }

            if (!empty($updatedFields)) {
                $employee->save();
                return response()->json(['message' => 'Employee updated successfully'], Response::HTTP_OK);
            }

            return response()->json(['message' => 'No changes detected'], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
