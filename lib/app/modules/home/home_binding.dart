import 'package:get/get.dart';
import 'package:zegen_test_app/app/modules/cart/cart_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
  }
}