<?php

use App\Http\Controllers\Auth\AuthenticationControlller;
use App\Http\Controllers\Threads\FriendController;
use App\Http\Controllers\Threads\ThreadController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/threads', [ThreadController::class, 'index']);
    Route::post('/create/thread', [ThreadController::class, 'store']);
    Route::post('/thread/like/{thread_id}', [ThreadController::class, 'react']);
    Route::post('/thread/comment', [ThreadController::class, 'comment']);
    Route::post('/thread/subcomment', [ThreadController::class, 'subcomment']);
    Route::post('/thread/follow/{following_id}', [FriendController::class, 'follow_and_unfollow']);
});


Route::post('/register', [AuthenticationControlller::class, 'register']);
Route::post('/login', [AuthenticationControlller::class, 'login']);

