import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/Pages/home_view.dart';
import 'package:myapp/Pages/login_view.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var user = {}.obs;
  var token = ''.obs;

  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    // jika kosong maka tampilkan pesan error snackbar
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'TOLONG DI ISI, JANGAN BIARKAN KOSONG',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    var headers = {'Content-Type': 'application/json'};
    var data = {"email": email, "password": password};
    try {
      var response = await _dio.post(
        'https://izzam.masa.my.id/api/auth/login',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        token.value = responseData['data']['token'];
        user.value = responseData['data']['user'];

        // save user.value to Hive
        var box = Hive.box('authBox');
        box.put('user', responseData['data']['user']);
        box.put('token', token.value);

        isLoggedIn.value = true;
        Get.offAll(HomeView());
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Login failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> register(String name, String email, String password) async {
    // jika kosong maka tampilkan pesan error snackbar
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'TOLONG DI ISI, JANGAN BIARKAN KOSONG',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    var headers = {'Content-Type': 'application/json'};
    var data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password
    };
    try {
      var response = await _dio.post(
        'https://izzam.masa.my.id/api/auth/register',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        token.value = responseData['data']['token'];
        user.value = responseData['data']['user'];
        // save
        var box = Hive.box('authBox');
        box.put('user', responseData['data']['user']);

        box.put('token', token.value);

        isLoggedIn.value = true;
        Get.offAll(HomeView());
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } catch (e) {
      Get.snackbar("Error", "Registration failed",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() {
    var box = Hive.box('authBox');
    box.delete('token');
    isLoggedIn.value = false;
    Get.offAll(LoginView());
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var box = Hive.box('authBox');
      if (box.containsKey('token')) {


        token.value = box.get('token');
        isLoggedIn.value = true;
        // passing userBox to obx
        user.value = box.get('user');
        Get.offAll(HomeView());
      }
    });
  }
}
