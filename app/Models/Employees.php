<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employees extends Model
{
    use HasFactory;
    protected $table = 'employees';

    protected $fillable = [
        'name',
        'last_name',
        'department',
        'has_access',
        'employee_id',
    ];
    public function accessAttempts()
    {
        return $this->hasMany(AccessAttempts::class, 'employee_id', 'employee_id');
    }
}
