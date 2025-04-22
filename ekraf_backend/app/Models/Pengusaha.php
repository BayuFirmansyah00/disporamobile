<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengusaha extends Model
{
    protected $table = 'pengusaha';
    protected $fillable = ['nama', 'foto_url', 'usaha_id'];

    public function usaha()
    {
        return $this->belongsTo(Usaha::class, 'usaha_id');
    }
}