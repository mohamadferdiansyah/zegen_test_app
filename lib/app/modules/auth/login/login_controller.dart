import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:zegen_test_app/app/modules/splash/splash_controller.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/services/api_service.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/modules/profile/profile_controller.dart';
import 'package:zegen_test_app/app/models/user_model.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    final username = emailController.text.trim();
    final password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      showToastification(
        context: Get.context!,
        type: ToastificationType.warning,
        title: 'Validation',
        description: 'Username and password are required.',
        style: ToastificationStyle.flatColored,
      );
      return;
    }

    try {
      isLoading.value = true;
      final token = await ApiService.instance.login(username, password);
      isLoading.value = false;

      final usersCtrl = Get.find<SplashController>();
      final UserModel? user = usersCtrl.findByUsernameOrEmail(username);
      if (user != null) {
        final profile = Get.find<ProfileController>();
        profile.setUser(user);
        print("${user.firstname} ${user.email} ${user.username}");
      }

      showSuccessToast(
        Get.context!,
        title: 'Login Successful',
        description: 'Token saved.',
      );

      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      isLoading.value = false;
      final message = (e is ApiException)
          ? e.message
          : (e is String ? e : e.toString());
      showToastification(
        context: Get.context!,
        type: ToastificationType.error,
        title: 'Login Failed',
        description: message,
        style: ToastificationStyle.flatColored,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
