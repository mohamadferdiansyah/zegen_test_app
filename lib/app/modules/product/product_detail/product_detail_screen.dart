import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/user_model.dart';
import 'package:zegen_test_app/app/modules/cart/cart_controller.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_controller.dart';
import 'package:zegen_test_app/app/modules/profile/profile_controller.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'package:zegen_test_app/app/widgets/custom_circle_button.dart';
import 'package:zegen_test_app/app/widgets/custom_rating_chip.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Map<String, dynamic>? ?? {};
    final image =
        product['image'] as String? ??
        'https://assets.xboxservices.com/assets/fb/d2/fbd2f5a4-13bc-47c1-abb1-667a673038e1.png';
    final name = product['name'] as String? ?? 'Product';
    final description =
        product['description'] as String? ?? 'ini adalah deskripsi';
    final price = product['price'] as String? ?? '0.00';
    final rating = product['rating'] as String? ?? '0.0';
    final ratingCount = product['ratingCount'] as String? ?? '0.0';
    final category = product['category'] as String? ?? '0.0';

    final ProductFavouriteController favCtrl =
        Get.find<ProductFavouriteController>();

    final ProfileController profileController = Get.find<ProfileController>();
    final CartController cartController = Get.find<CartController>();

    void _showLoginDialog() {
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
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.userLock,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Login Required",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please login to your account to add items to your Wishlist.",
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
                          Get.toNamed(AppRoutes.LOGIN);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Login",
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              color: AppColors.background,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Image.network(image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCircleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Get.back(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        final isFav = favCtrl.contains(product);
                        return CustomCircleButton(
                          icon: isFav
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          iconColor: isFav ? Colors.red : null,
                          onTap: () {
                            final UserModel? u = profileController.user.value;

                            if (u == null) {
                              _showLoginDialog();
                              return;
                            }

                            favCtrl.toggleWishlist(product);
                            if (isFav) {
                              showSuccessToast(
                                context,
                                title: "Removed from Wishlist",
                                description:
                                    "This item has been removed from your Wishlist.",
                              );
                            } else {
                              showSuccessToast(
                                context,
                                title: "Added to Wishlist",
                                description:
                                    "This item has been added to your Wishlist.",
                              );
                            }
                          },
                        );
                      }),
                      const SizedBox(width: 15),
                      Stack(
                        children: [
                          CustomCircleButton(
                            icon: FontAwesomeIcons.basketShopping,
                            onTap: () {
                              final UserModel? u = profileController.user.value;
                              if (u == null) {
                                _showLoginDialog();
                                return;
                              }
                              Get.toNamed(AppRoutes.CART);
                            },
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Obx(() {
                              final count = cartController.totalItems;
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "% On sale",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          Row(
                            children: [
                              CustomRatingChip(
                                icon: FontAwesomeIcons.solidStar,
                                label: rating,
                                iconColor: Colors.orange,
                              ),
                              const SizedBox(width: 10),
                              const CustomRatingChip(
                                icon: FontAwesomeIcons.solidThumbsUp,
                                label: "94%",
                                iconColor: AppColors.primary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${ratingCount} Reviews",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          CustomRatingChip(
                            icon: FontAwesomeIcons.layerGroup,
                            label: category,
                            iconColor: Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.grey[600],
                              height: 1.5,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$650.00",
                            style: TextStyle(
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "\$$price",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                          text: 'Add To Cart',
                          onPressed: () {
                            cartController.addItem(product);
                            showSuccessToast(
                              context,
                              title: "Added to Cart",
                              description:
                                  "This item has been added to your cart.",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
