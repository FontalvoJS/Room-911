<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccessAttempts extends Model
{
    use HasFactory;
    protected $table = 'access_attempts';
    public $timestamps = false;
    protected $fillable = ['attempted_at', 'employee_id', 'was_successful', 'ip', 'employee'];
}