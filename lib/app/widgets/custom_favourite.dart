import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zegen_test_app/app/modules/root/root_controller.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class CustomFavourite extends StatelessWidget {
  const CustomFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              FontAwesomeIcons.heart,
              size: 80,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Your wishlist is empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Save items you like here\nto buy them later.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], height: 1.5),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              final root = Get.find<RootController>();
              root.changeIndex(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Browse Products",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
