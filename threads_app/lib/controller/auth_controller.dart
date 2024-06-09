import 'package:get/get.dart';
import 'package:threads_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/widget/bottom_bar.dart';
import 'package:threads_app/constants/const.dart';

class AuthController extends GetxController {
  bool isLoading = false;

  final ApiService _apiService =
      ApiService(baseUrl: 'http://172.20.10.4:8000/api');

  void responseLoad() {
    isLoading = !isLoading;
    update();
  }

  Future<void> registerUser(
      String email, String name, String username, String password) async {
    responseLoad();
    try {
      final response = await _apiService.post(
        '/register',
        {
          'email': email,
          'name': name,
          'username': username,
          'password': password
        },
      );
      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          'Welcome',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        var token = response['token'];
        box.write('token', token);
        Get.offAll(
          () => const BottomBar(),
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      responseLoad();
    }
  }

  Future<void> loginUser(String username, String password) async {
    responseLoad();
    try {
      final response = await _apiService.post(
        '/login',
        {'username': username, 'password': password},
      );
      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          'Welcome',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        var token = response['token'];
        box.write('token', token);
        Get.offAll(
          () => const BottomBar(),
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      responseLoad();
    }
  }
}
