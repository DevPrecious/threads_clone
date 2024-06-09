<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ThreadResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'body' => $this->body,
            'image' => $this->image == null ? null :  'http://172.20.10.4:8000/' . str_replace('public', 'storage', (string) $this->image),
            'created_at' => $this->created_at->diffForHumans(),
            'user' => $this->user,
            'is_liked' => $this->likes->contains('user_id', auth()->id()),
            'likes' => $this->likes->count(),
            'comments' => CommentResource::collection($this->comments),
        ];
    }
}
