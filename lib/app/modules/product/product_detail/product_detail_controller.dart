import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  Map<String, dynamic>? product;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Map<String, dynamic>?;
  }
}
