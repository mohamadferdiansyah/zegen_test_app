import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_input.dart';
import 'package:zegen_test_app/app/widgets/custom_product_card_grid.dart';
import 'package:zegen_test_app/app/widgets/custom_product_card_list.dart';
import 'package:zegen_test_app/app/widgets/custom_toggle_button.dart';
import 'product_list_controller.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductListController());
    final TextEditingController searchController = TextEditingController(
      text: controller.query.value,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(FontAwesomeIcons.chevronLeft, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInput(
                      controller: searchController,
                      hintText: "Search results...",
                      prefixIcon: Icons.search,
                      backgroundColor: AppColors.background,
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
                        controller.search(q);
                      },
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
                        controller.search(q);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.CART),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black87),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.basketShopping,
                            size: 18,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      "${controller.products.length} Products found",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomToggleButton(
                      isGrid: controller.isGridView.value,
                      onTap: () => controller.toggleView(),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isGridView.value) {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final p = controller.products[index];
                      return CustomProductCardGrid(
                        name: p.title,
                        description: p.description,
                        price: p.priceString,
                        rating: p.rating.toString(),
                        ratingCount: p.ratingCount.toString(),
                        category: p.category,
                        image: p.image,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final p = controller.products[index];
                      return CustomProductCardList(
                        name: p.title,
                        description: p.description,
                        price: p.priceString,
                        rating: p.rating.toString(),
                        ratingCount: p.ratingCount.toString(),
                        category: p.category,
                        image: p.image,
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
