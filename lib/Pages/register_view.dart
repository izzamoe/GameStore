import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.register(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
