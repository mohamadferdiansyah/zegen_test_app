import 'package:get/get.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_binding.dart';
import 'package:zegen_test_app/app/modules/search/search_binding.dart';
import '../home/home_binding.dart';
import '../profile/profile_binding.dart';
import 'root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
    HomeBinding().dependencies();
    SearchBinding().dependencies();
    ProductFavouriteBinding().dependencies();
    ProfileBinding().dependencies();
  }
}