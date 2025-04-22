<?php

// namespace App\Models;

// use Illuminate\Database\Eloquent\Model;

// class Subsektor extends Model
// {
//     protected $table = 'subsektor'; // Pastikan nama tabel benar
//     protected $fillable = ['sektor_id', 'nama', 'gambar_url', 'keterangan', 'jumlah_pengusaha'];
// }

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Usaha;
use App\Models\Pengusaha;

class Subsektor extends Model
{
    protected $table = 'subsektor'; // Pastikan nama tabel benar
    protected $fillable = ['sektor_id', 'nama', 'gambar_url', 'keterangan', 'jumlah_pengusaha'];

    // Relasi ke tabel usaha
    public function usaha()
    {
        return $this->hasMany(Usaha::class, 'subsektor_id');
    }

    // Relasi ke pengusaha lewat usaha (hasManyThrough)
    public function pengusaha()
    {
        return $this->hasManyThrough(
            Pengusaha::class,   // Model tujuan akhir
            Usaha::class,       // Model perantara
            'subsektor_id',     // foreign key di tabel usaha
            'usaha_id',         // foreign key di tabel pengusaha
            'id',               // primary key di subsektor
            'id'                // primary key di usaha
        );
    }
}