import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/LibraryController.dart';

class LibraryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LibraryController controller = Get.put(LibraryController());

    return Scaffold(
      appBar: AppBar(title: Text('Library')),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              var product = controller.products[index];
              return ListTile(
                  leading: Image.network(
                    product['produk']['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product['produk']['name']),
                  subtitle: Text(product['produk']['desc']));
            },
          );
        }
      }),
    );
  }
}
