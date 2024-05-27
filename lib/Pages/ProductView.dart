import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ProductController.dart';


class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Column(
              children: controller.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            product['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product['name']),
                          subtitle: Text(product['desc']),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product['price']),
                              ElevatedButton(
                                onPressed: () => controller.buyProduct(product['id']),
                                child: Text('Buy'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      }),
    );
  }
}
