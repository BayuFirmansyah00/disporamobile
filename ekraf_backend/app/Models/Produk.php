<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Produk extends Model
{
    protected $table = 'produk';
    protected $fillable = ['usaha_id', 'nama', 'foto_url', 'informasi', 'harga'];

    public function usaha()
    {
        return $this->belongsTo(Usaha::class, 'usaha_id');
    }
}