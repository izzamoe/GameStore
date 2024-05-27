import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(() {
        if (authController.user.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Name: ${authController.user['name']}'),
                Text('Email: ${authController.user['email']}'),
                ElevatedButton(
                  onPressed: () {
                    authController.logout();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
