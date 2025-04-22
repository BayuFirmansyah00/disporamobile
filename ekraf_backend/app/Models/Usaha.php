<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Usaha extends Model
{
    protected $table = 'usaha';
    protected $fillable = [
        'nama_toko', 'logo_url', 'sektor_id', 'subsektor_id', 
        'no_hp', 'alamat', 'mode_pemesanan'
    ];

    public function sektor()
    {
        return $this->belongsTo(Sector::class, 'sektor_id');
    }

    public function subsektor()
    {
        return $this->belongsTo(Subsektor::class, 'subsektor_id');
    }

    public function pengusaha()
    {
        return $this->hasMany(Pengusaha::class, 'usaha_id');
    }

    public function produk()
    {
        return $this->hasMany(Produk::class, 'usaha_id');
    }
}