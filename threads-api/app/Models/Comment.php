<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Comment extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'thread_id',
        'body'
    ];

    public function thread() : BelongsTo
    {
        return $this->belongsTo(Thread::class);
    }

    public function subcomments() : HasMany
    {
        return $this->hasMany(SubComment::class);
    }
}
