import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/models/user_model.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_tile_profile.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final UserModel? u = profileController.user.value;
        if (u == null) {
          return _buildGuestView();
        }
        return _buildUserView(context, u);
      }),
    );
  }

  Widget _buildGuestView() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const FaIcon(
              FontAwesomeIcons.userSlash,
              size: 80,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Oops! You haven't logged in",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Login now to view your profile, track orders, and manage your shipping addresses.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: "Login Now",
            onPressed: () {
              Get.toNamed(AppRoutes.LOGIN);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.REGISTER);
            },
            child: const Text(
              "Don't have an account? Sign up",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserView(BuildContext context, UserModel user) {
    void _showLogoutConfirmation(BuildContext context) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Are you sure you want to logout from your account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(color: Colors.black12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.offAllNamed(
                            AppRoutes.HOME,
                          );
                          final ProfileController controller =
                              Get.find<ProfileController>();
                          controller.clearUser();
                          showSuccessToast(
                            context,
                            title: "Logout Successful",
                            description: "You have been logged out.",
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        transitionCurve: Curves.easeInOutBack,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        "${(user.firstname.isNotEmpty ? user.firstname[0] : '')}${(user.lastname.isNotEmpty ? user.lastname[0] : '')}"
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.09),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.pen,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "${user.firstname} ${user.lastname}".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@${user.username}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          _buildSectionTitle("Personal Information"),
          _buildInfoCard([
            CustomTileProfile(
              icon: FontAwesomeIcons.envelope,
              label: "Email Address",
              value: "${user.email}",
            ),
            CustomTileProfile(
              icon: FontAwesomeIcons.phone,
              label: "Phone Number",
              value: "${user.phone}",
            ),
          ]),

          const SizedBox(height: 20),

          _buildSectionTitle("Shipping Address"),
          _buildInfoCard([
            CustomTileProfile(
              icon: FontAwesomeIcons.locationDot,
              label: "Street",
              value:
                  "${user.address['street'] ?? ''} No. ${user.address['number'] ?? ''}",
            ),
            CustomTileProfile(
              icon: FontAwesomeIcons.city,
              label: "City & Zipcode",
              value:
                  "${user.address['city'] ?? ''}, ${user.address['zipcode'] ?? ''}",
            ),
          ]),

          const SizedBox(height: 20),

          _buildInfoCard([
            ListTile(
              onTap: () {
                _showLogoutConfirmation(context);
              },
              leading: const FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Colors.redAccent,
                size: 20,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ]),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
