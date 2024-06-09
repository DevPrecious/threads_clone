<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthenticationControlller extends Controller
{
    public function register(RegisterRequest $registerRequest)
    {
        try {
            $registerRequest->validated();

            $user = User::create([
                'name' => $registerRequest->name,
                'username' => $registerRequest->username,
                'email' => $registerRequest->email,
                'password' => Hash::make($registerRequest->password)
            ]);

            $token = $user->createToken('threads')->plainTextToken;

            return response([
                'success' => true,
                'user' => $user,
                'token' => $token
            ], 201);

        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function login(LoginRequest $loginRequest)
    {
        try {
            $loginRequest->validated();

            // chek user
            $user = User::whereUsername($loginRequest->username)->first();
            if(!$user || !Hash::check($loginRequest->password, $user->password)){
                return response([
                    'message' => 'Invalid Credentials'
                ], 422);
            }

            $token = $user->createToken('threads')->plainTextToken;

            return response([
                'success' => true,
                'user' => $user,
                'token' => $token
            ], 200);

        } catch (\Exception $e) {
            return response([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
