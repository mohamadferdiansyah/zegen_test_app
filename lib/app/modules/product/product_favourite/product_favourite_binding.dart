import 'package:get/get.dart';
import 'product_favourite_controller.dart';

class ProductFavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductFavouriteController>(() => ProductFavouriteController());
  }
}