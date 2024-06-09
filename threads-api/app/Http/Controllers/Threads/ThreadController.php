<?php

namespace App\Http\Controllers\Threads;

use App\Http\Controllers\Controller;
use App\Http\Requests\ThreadRequest;
use App\Http\Resources\ThreadResource;
use App\Models\Comment;
use App\Models\Like;
use App\Models\SubComment;
use App\Models\Thread;
use Illuminate\Http\Request;

class ThreadController extends Controller
{


    public function index()
    {
        try {
            $threads = Thread::with('user')->with('likes')->with('comments')->latest()->get();
            $threads = ThreadResource::collection($threads);
            return response([
                'threads' => $threads
            ]);
        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function store(ThreadRequest $threadRequest)
    {
        try {
           $threadRequest->validated();
           $data = [
            'body' => $threadRequest->body
           ];

        // check image
        if(!empty($threadRequest->file('image'))) {
            $threadRequest->validate([
                'image' => 'image'
            ]);
            $imagePath = 'public/images/threads';
            $image = $threadRequest->file('image');
            $image_name = $image->getClientOriginalName();
            $path = $threadRequest->file('image')->storeAs($imagePath, rand(0, 0) . $image_name);
            //dd($path);

            $data['image'] = $path;
        }

        //dd($data);

        $save = auth()->user()->threads()->create($data);

        if($save) {
            return response([
                'thread' => $save,
                'message' => 'success'
            ], 201);
        }else{
            return response([
                'message' => 'eror'
            ], 500);
        }

        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function react($thread_id)
    {
        try {
            $thread = Like::whereThreadId($thread_id)->whereUserId(auth()->id())->first();
            if($thread){
                Like::whereThreadId($thread_id)->whereUserId(auth()->id())->delete();
                return response([
                    'message' => 'unliked'
                ], 200);
            }else{
                Like::create([
                    'user_id' => auth()->id(),
                    'thread_id' => $thread_id
                ]);
                return response([
                    'message' => 'liked'
                ], 201);
            }
        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function comment(Request $request)
    {
        try {
            $request->validate([
                'thread_id' => 'required',
                'body' => 'required|string'
            ]);
            $comment = Comment::create([
                'user_id' => auth()->id(),
                'thread_id' => $request->thread_id,
                'body' => $request->body
            ]);
            if($comment) {
                return response([
                    'message' => 'success'
                ], 201);
            }else{
                return response([
                    'message' => 'error'
                ], 500);
            }
        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function subcomment(Request $request)
    {
        try {
            $request->validate([
                'comment_id' => 'required',
                'body' => 'required|string'
            ]);
            $comment = SubComment::create([
                'user_id' => auth()->id(),
                'comment_id' => $request->comment_id,
                'body' => $request->body
            ]);
            if($comment) {
                return response([
                    'message' => 'success'
                ], 201);
            }else{
                return response([
                    'message' => 'error'
                ], 500);
            }
        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
