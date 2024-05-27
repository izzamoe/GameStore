import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/home_controller.dart';
import 'package:myapp/Pages/ProductView.dart';
import 'package:myapp/Pages/library_view.dart';
import 'package:myapp/Pages/profile_view.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  static final List<Widget> _widgetOptions = <Widget>[
    ProductView(),
    ProfileView(),
    LibraryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _widgetOptions.elementAt(homeController.selectedIndex.value);
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Store'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: 'Library'),
          ],
          currentIndex: homeController.selectedIndex.value,
          selectedItemColor: Colors.amber[800],
          onTap: homeController.changePage,
        );
      }),
    );
  }
}
