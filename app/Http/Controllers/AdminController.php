<?php

namespace App\Http\Controllers;

use App\Models\AccessAttempts;
use App\Models\Departments;
use App\Models\Employees;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;
use Ramsey\Uuid\Uuid;
use App\Services\FileProcessorService;
use Barryvdh\DomPDF\Facade\Pdf;
// use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;


class AdminController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    protected $fileProcessorService;

    public function __construct(FileProcessorService $fileProcessorService)
    {
        $this->middleware('auth');
        $this->fileProcessorService = $fileProcessorService;
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
            $employees = Employees::select(
                'employees.id',
                'employees.employee_id',
                'employees.name',
                'employees.last_name',
                'departments.name as department',
                'employees.has_access',
                DB::raw('(SELECT COUNT(*) FROM access_attempts WHERE access_attempts.employee_id = employees.employee_id AND access_attempts.was_successful = 1) as totalAccess'),
                DB::raw('(SELECT COUNT(*) FROM access_attempts WHERE access_attempts.employee_id = employees.employee_id AND access_attempts.was_successful = 0) as totalDenied')
            )
                ->join('departments', 'employees.department', '=', 'departments.id')
                ->orderBy('employees.id', 'desc')
                ->get();

            return response()->json(['employees' => $employees], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    public function getEmployeesByDate(Request $request)
    {
        try {
            // Obtener los parámetros de fecha del request
            $startDate = $request->input('start_date');
            $endDate = $request->input('end_date');

            // Construcción de la consulta base
            $employees = Employees::select(
                'employees.id',
                'employees.employee_id',
                'employees.name',
                'employees.last_name',
                'departments.name as department',
                'employees.has_access',
                // Cálculo de totalAccess con filtro de fecha si está disponible
                DB::raw('(SELECT COUNT(*) 
                      FROM access_attempts 
                      WHERE access_attempts.employee_id = employees.employee_id 
                      AND access_attempts.was_successful = 1' .
                    ($startDate ? ' AND access_attempts.attempted_at >= "' . $startDate . '"' : '') .
                    ($endDate ? ' AND access_attempts.attempted_at <= "' . $endDate . '"' : '') .
                    ') as totalAccess'),
                // Cálculo de totalDenied con filtro de fecha si está disponible
                DB::raw('(SELECT COUNT(*) 
                      FROM access_attempts 
                      WHERE access_attempts.employee_id = employees.employee_id 
                      AND access_attempts.was_successful = 0' .
                    ($startDate ? ' AND access_attempts.attempted_at >= "' . $startDate . '"' : '') .
                    ($endDate ? ' AND access_attempts.attempted_at <= "' . $endDate . '"' : '') .
                    ') as totalDenied')
            )
                ->join('departments', 'employees.department', '=', 'departments.id')
                ->having('totalAccess', '>', 0)
                ->orHaving('totalDenied', '>', 0)
                ->get();

            // Verificar si se encontraron empleados
            if ($employees->isEmpty()) {
                return response()->json(['error' => 'No employees found'], Response::HTTP_NOT_FOUND);
            }

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
            if (!$employee) {
                return response()->json(['error' => 'Employee not found'], Response::HTTP_NOT_FOUND);
            }
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
    public function uploadFile(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:csv,xlsx,xls',
        ]);

        try {
            $file = $request->file('file');
            $data = $this->fileProcessorService->processFile($file);

            // Inicializa un array para capturar errores
            $errors = [];

            // Aquí puedes procesar los datos como desees, por ejemplo, guardar en la base de datos
            foreach ($data as $index => $row) {
                // Validaciones adicionales
                if (empty($row['name']) || empty($row['lastname']) || empty($row['department']) || !isset($row['has_access'])) {
                    $errors[] = "Row $index: Missing required fields.";
                    continue;
                }

                $department = Departments::where('name', $row['department'])->first();
                if (!$department) {
                    $errors[] = "Row $index: Department '{$row['department']}' not found.";
                    continue;
                }

                try {
                    Employees::create([
                        'name' => $row['name'],
                        'last_name' => $row['lastname'],
                        'department' => $department->id,
                        'employee_id' => strtoupper(str_replace('-', '', Uuid::uuid4()->toString())),
                        'has_access' => $row['has_access'] === "true" ? 1 : 0,
                    ]);
                } catch (\Exception $e) {
                    $errors[] = "Row $index: " . $e->getMessage();
                }
            }

            if (!empty($errors)) {
                return response()->json(['message' => 'File processed with some errors, check your file and try again', 'errors' => $errors], Response::HTTP_PARTIAL_CONTENT);
            }

            return response()->json(['message' => 'File processed successfully'], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getAccessHistory(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|string|min:10',
        ]);

        try {
            $employee = Employees::select(
                'employees.employee_id',
                'employees.name as name',
                'employees.last_name',
                'departments.name as department',
                'employees.has_access'
            )
                ->join('departments', 'employees.department', '=', 'departments.id')
                ->where('employee_id', $request->employee_id)
                ->first();

            if (!$employee) {
                return response()->json(['message' => 'Employee not found'], Response::HTTP_NOT_FOUND);
            }

            $accessAttempts = AccessAttempts::where('employee_id', $request->employee_id)->get();

            // Calcular los totales
            $totalAttempts = $accessAttempts->count();
            $successfulAttempts = $accessAttempts->where('was_successful', true)->count();
            $deniedAttempts = $accessAttempts->where('was_successful', false)->count();

            $pdf = Pdf::loadView('pdf.access_history', [
                'employee' => $employee,
                'accessAttempts' => $accessAttempts,
                'totalAttempts' => $totalAttempts,
                'successfulAttempts' => $successfulAttempts,
                'deniedAttempts' => $deniedAttempts,
            ]);

            return $pdf->download('access_history.pdf');
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
