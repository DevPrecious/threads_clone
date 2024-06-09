import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_app/controller/auth_controller.dart';
import 'package:threads_app/features/auth/views/login_view.dart';
import 'package:threads_app/features/auth/wdgets/auth_input_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final AuthController authController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    authController = Get.put(AuthController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    usernameController.dispose();
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
              'Register',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthInputWidget(
              controller: emailController,
              hinText: 'Email Address',
            ),
            const SizedBox(
              height: 30,
            ),
            AuthInputWidget(
              controller: nameController,
              hinText: 'Full name',
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
            GetBuilder<AuthController>(
                init: authController,
                builder: (controller) {
                  return controller.isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            await controller.registerUser(
                              emailController.text.trim(),
                              nameController.text.trim(),
                              usernameController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                          child: const Chip(
                            label: Text('Sign in'),
                          ),
                        );
                }),
            TextButton(
              onPressed: () {
                Get.to(
                  () => const LoginView(),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
