import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/user_model.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_controller.dart';
import 'package:zegen_test_app/app/modules/profile/profile_controller.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'package:zegen_test_app/app/widgets/custom_favourite.dart';
import 'package:zegen_test_app/app/widgets/custom_product_card_grid.dart';

class ProductFavouriteScreen extends StatelessWidget {
  const ProductFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFavouriteController controller = Get.find<ProductFavouriteController>();
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final UserModel? u = profileController.user.value;
        if (u == null) {
          return _buildGuestView();
        }
        if (controller.isEmpty) {
          return const CustomFavourite();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "${controller.favoriteItems.length} Items",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: controller.favoriteItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    var item = controller.favoriteItems[index];
                    return Stack(
                      children: [
                        CustomProductCardGrid(
                          name: item.name,
                          description: item.description,
                          price: item.priceString,
                          rating: item.ratingString,
                          ratingCount: item.ratingCount.toString(),
                          category: item.category,
                          image: item.image,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              controller.removeFromWishlistAt(index);
                              showSuccessToast(
                                context,
                                title: "Removed from Wishlist",
                                description: "Successfully removed from your Wishlist.",
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
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
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const FaIcon(
              FontAwesomeIcons.heartCircleXmark,
              size: 80,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Login to see your Wishlist",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Save items you love and keep track of them by logging in to your account.",
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
}