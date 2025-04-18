<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sector extends Model
{
    protected $table = 'sektor';
    protected $fillable = ['nama', 'icon_url'];
}