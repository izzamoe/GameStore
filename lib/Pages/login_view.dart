import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/auth_controller.dart';
import 'package:myapp/Pages/register_view.dart';


class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(RegisterView());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
