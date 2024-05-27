import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/Pages/login_view.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Login',
      home: LoginView(),
    );
  }
}
