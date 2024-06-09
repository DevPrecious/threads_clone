<?php

namespace App\Http\Controllers\Threads;

use App\Http\Controllers\Controller;
use App\Models\Friend;
use Illuminate\Http\Request;

class FriendController extends Controller
{
    public function follow_and_unfollow($following_id)
    {
        try {
            $check_if_follow = Friend::whereFollowingId($following_id)->exists();
            if ($check_if_follow) {
                Friend::whereFollowingId($following_id)->delete();
            } else {
                Friend::create([
                    'following_id' => (int) $following_id,
                    'follower_id' => auth()->id()
                ]);
            }

            return response([
                'message' => 'success'
            ], 200);
        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
