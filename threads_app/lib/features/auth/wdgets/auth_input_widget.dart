import 'package:flutter/material.dart';

class AuthInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hinText;

  const AuthInputWidget({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.hinText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hinText,
      ),
    );
  }
}
