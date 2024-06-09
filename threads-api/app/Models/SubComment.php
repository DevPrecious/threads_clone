<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SubComment extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'comment_id',
        'body'
    ];

    public function subcomment() : BelongsTo
    {
        return $this->belongsTo(Comment::class);
    }
}
