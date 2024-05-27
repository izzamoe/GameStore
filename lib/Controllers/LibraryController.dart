import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LibraryController extends GetxController {
  //
  // The list of products
  var products = [].obs;

  // fetch pas awal awal
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Fetch products from the API
  Future<void> fetchProducts() async {
    var box = Hive.box('authBox');
    var token = box.get('token');
    var headers = {'Authorization': "Bearer " + token};
    var dio = Dio();
    try {
      var response = await dio.request(
      'https://izzam.masa.my.id/api/profile/library',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      // Update the list of products
      products.value = response.data['data'];
      print(products);
      // Show a success message
      // Get.snackbar('Success', 'Products fetched successfully');
    } else {
      // Show an error message
      Get.snackbar('Error', 'Failed to fetch products');
    }
    } catch (e) {
      // Show an error message
      Get.snackbar('Error', 'Failed to fetch products');
    }
  }
}
