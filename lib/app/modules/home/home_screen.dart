import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:toastification/toastification.dart';
import 'package:zegen_test_app/app/models/product_model.dart';
import 'package:zegen_test_app/app/models/user_model.dart';
import 'package:zegen_test_app/app/modules/cart/cart_controller.dart';
import 'package:zegen_test_app/app/modules/home/home_controller.dart';
import 'package:zegen_test_app/app/modules/profile/profile_controller.dart';
import 'package:zegen_test_app/app/modules/search/search_controller.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_chip.dart';
import 'package:zegen_test_app/app/widgets/custom_input.dart';
import 'package:zegen_test_app/app/widgets/custom_product_card_grid.dart';
import 'package:zegen_test_app/app/widgets/custom_product_card_list.dart';
import 'package:zegen_test_app/app/widgets/custom_promo_banner.dart';
import 'package:zegen_test_app/app/widgets/custom_toggle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final searchPageController = Get.find<SearchPageController>();
    final cartController = Get.find<CartController>();
    final profileController = Get.find<ProfileController>();
    final TextEditingController searchController = TextEditingController();

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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      final UserModel? u = profileController.user.value;
                      if (u == null) {
                        _showLoginDialog();
                        return;
                      }
                      Get.toNamed(AppRoutes.CART);
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black87),
                          ),
                          child: FaIcon(FontAwesomeIcons.basketShopping),
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
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CustomInput(
                  controller: searchController,
                  hintText: 'Search',
                  hintSize: 18,
                  backgroundColor: AppColors.background,
                  suffixIcon: FontAwesomeIcons.search,
                  onSuffixTap: () {
                    final q = searchController.text.trim();
                    if (q.isEmpty) {
                      showToastification(
                        context: context,
                        type: ToastificationType.warning,
                        title: 'Validation',
                        description: 'Please enter a search term.',
                        style: ToastificationStyle.flatColored,
                      );
                      return;
                    }
                    searchPageController.submitSearch(q);
                    searchController.clear();
                  },
                  onSubmitted: (v) {
                    final q = v?.trim() ?? '';
                    if (q.isEmpty) {
                      showToastification(
                        context: context,
                        type: ToastificationType.warning,
                        title: 'Validation',
                        description: 'Please enter a search term.',
                        style: ToastificationStyle.flatColored,
                      );
                      return;
                    }
                    searchPageController.submitSearch(q);
                    searchController.clear();
                  },
                ),
              ),
              const SizedBox(height: 24),
              const CustomPromoBanner(),
              const SizedBox(height: 24),
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: homeController.categories.map((cat) {
                            final active =
                                homeController.selectedCategory.value == cat;
                            return GestureDetector(
                              onTap: () => homeController.selectCategory(cat),
                              child: CustomChip(label: cat, isActive: active),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomToggleButton(
                        isGrid: homeController.isGridView.value,
                        onTap: () => homeController.toggleView(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (homeController.isLoading.value) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final List<ProductModel> products =
                    homeController.filteredProducts;

                if (homeController.isGridView.value) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      return CustomProductCardGrid(
                        name: p.name,
                        description: p.description,
                        category: p.category,
                        ratingCount: p.ratingCount.toString(),
                        price: p.priceString,
                        rating: p.ratingString,
                        image: p.image,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      return CustomProductCardList(
                        name: p.name,
                        description: p.description,
                        category: p.category,
                        ratingCount: p.ratingCount.toString(),
                        price: p.priceString,
                        rating: p.ratingString,
                        image: p.image,
                      );
                    },
                  );
                }
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
