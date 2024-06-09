<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Like extends Model
{
    use HasFactory;

    protected  $fillable = [
        'user_id',
        'thread_id',
    ];


    public function thread() : BelongsTo
    {
        return $this->belongsTo(Thread::class);
    }
}
