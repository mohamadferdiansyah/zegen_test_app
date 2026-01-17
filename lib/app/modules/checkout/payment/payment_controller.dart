import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';

class PaymentController extends GetxController {
  var selectedMethod = "Bank Transfer".obs;
  var isLoading = false.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  void processPayment(double total) async {
    isLoading.value = true;
    
    await Future.delayed(const Duration(seconds: 3));
    
    isLoading.value = false;
    
    Get.offNamed(AppRoutes.STATUS, arguments: {'total': total});
  }
}