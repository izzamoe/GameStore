import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductController extends GetxController {
  var products = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var box = Hive.box('authBox');
    var token = box.get('token');
    var headers = {'Authorization': "Bearer $token"};
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://izzam.masa.my.id/api/produk/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        products.value = response.data['data'];
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    }
  }

  Future<void> buyProduct(int productId) async {
    print(productId);
    var box = Hive.box('authBox');
    var token = box.get('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = json.encode({'produk_id': productId.toString()});
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://izzam.masa.my.id/api/produk/buy',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product purchased successfully');
      } else {
        Get.snackbar('Error', 'Failed to purchase product');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          Get.snackbar('Sukses', 'Product already purchased');
        } else {
          Get.snackbar('Error', 'Failed to purchase product');
        }
      } else {
        Get.snackbar('Error', 'Failed to purchase product');
      }
    }
  }
}
