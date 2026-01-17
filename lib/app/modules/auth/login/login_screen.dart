import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/modules/auth/login/login_controller.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'package:zegen_test_app/app/widgets/custom_input.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    final c = controller;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: -40,
              right: -40,
              child: _buildCircle(300, AppColors.primary.withOpacity(0.15)),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: BottomWaveClipper(),
                child: Container(
                  height: screenHeight * 0.35,
                  color: AppColors.primary.withOpacity(0.1),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      const Text(
                        "Login to continue shopping",
                        style: TextStyle(fontSize: 16, color: AppColors.grey),
                      ),
                      const SizedBox(height: 40),

                      CustomInput(
                        hintText: "Username",
                        prefixIcon: FontAwesomeIcons.solidEnvelope,
                        controller: c.emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        hintText: "Password",
                        prefixIcon: FontAwesomeIcons.lock,
                        isPassword: true,
                        controller: c.passwordController,
                      ),

                      const SizedBox(height: 30),
                      Obx(() {
                        return CustomButton(
                          text: c.isLoading.value ? 'Loading...' : "Login",
                          onPressed: c.isLoading.value ? () {} : c.login,
                        );
                      }),

                      const SizedBox(height: 40),

                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Or continue with",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialButton(
                                  FontAwesomeIcons.google,
                                  Colors.redAccent,
                                ),
                                const SizedBox(width: 20),
                                _buildSocialButton(
                                  FontAwesomeIcons.facebookF,
                                  Colors.blueAccent,
                                ),
                                const SizedBox(width: 20),
                                _buildSocialButton(
                                  FontAwesomeIcons.apple,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.REGISTER),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 45,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(child: FaIcon(icon, color: color, size: 22)),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.3);

    var firstControlPoint = Offset(size.width * 0.25, 0);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.3);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.6);
    var secondEndPoint = Offset(size.width, size.height * 0.3);

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
