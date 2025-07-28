// login_form_controller.dart

import 'package:flutter/material.dart';

class LoginFormController {




  static final String initialEmail = 'admin@gmail.com';
  static final String initialPassword = 'shahil';
  final TextEditingController emailController = TextEditingController(text: initialEmail);
  final TextEditingController passwordController = TextEditingController(text: initialPassword);

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  bool validateInputs() {
    return emailController.text.isNotEmpty &&
        passwordController.text.length > 6;
  }

  Map<String, String> getValues() {
    return {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };
  }
}
