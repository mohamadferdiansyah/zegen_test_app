import 'package:get/get.dart';
import 'package:zegen_test_app/app/modules/cart/cart_controller.dart';
import 'product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}