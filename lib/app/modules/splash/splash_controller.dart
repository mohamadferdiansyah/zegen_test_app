import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/user_model.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/services/api_service.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class SplashController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
    } else {
      _proceedToLoadData();
    }
  }

  Future<void> _proceedToLoadData() async {
    await loadUsers();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.HOME);
    });
  }

  Future<void> loadUsers() async {
    try {
      isLoading.value = true;
      final list = await ApiService.instance.fetchAllUsers();
      users.assignAll(list);
      print("DATA USER BERHASIL DI LOAD");
    } catch (e) {
      print("ERROR LOAD USER: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.wifi,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "No Connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Please check your internet connection and try again to continue shopping.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    checkConnection();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  UserModel? findByUsernameOrEmail(String key) {
    final lower = key.toLowerCase();
    return users.firstWhereOrNull(
      (u) => u.username.toLowerCase() == lower || u.email.toLowerCase() == lower,
    );
  }
}