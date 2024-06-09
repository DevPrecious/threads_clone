import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_app/controller/auth_controller.dart';
import 'package:threads_app/features/auth/views/register_view.dart';
import 'package:threads_app/features/auth/wdgets/auth_input_widget.dart';
import 'package:threads_app/features/home/home.dart';
import 'package:threads_app/widget/bottom_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final AuthController authController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    authController = Get.put(AuthController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthInputWidget(
              controller: usernameController,
              hinText: 'Username',
            ),
            const SizedBox(
              height: 30,
            ),
            AuthInputWidget(
              controller: passwordController,
              hinText: 'Password',
              isPassword: true,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => const BottomBar(),
                );
              },
              child: GetBuilder<AuthController>(
                  init: authController,
                  builder: (controller) {
                    return controller.isLoading ?
                    const CircularProgressIndicator() :
                    GestureDetector(
                      onTap: () async {
                        await controller.loginUser(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: const Chip(
                        label: Text('Login'),
                      ),
                    );
                  }),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => const RegisterView(),
                );
              },
              child: const Text('Dont have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
