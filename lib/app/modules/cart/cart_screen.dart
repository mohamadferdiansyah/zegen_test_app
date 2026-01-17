import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'package:zegen_test_app/app/widgets/custom_cart_card.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    void _showPromoBottomSheet(BuildContext context) {
      Get.bottomSheet(
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.confirmation_number_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sorry, there are no promotions available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Stay tuned to our app for exciting promotions!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Close",
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
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: AppColors.text,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  var item = controller.items[index];
                  return CustomCartCard(
                    name: item.name,
                    category: item.category,
                    price: item.price,
                    image: item.image,
                    quantity: item.quantity.value,
                    onAdd: () => controller.increaseQty(index),
                    onRemove: () => controller.decreaseQty(index),
                    onDelete: () {
                      controller.removeItem(index);
                      showSuccessToast(
                        context,
                        title: "Removed from Cart",
                        description: "Successfully removed from your Cart.",
                      );
                    },
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _showPromoBottomSheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Use the promo code",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const FaIcon(
                            FontAwesomeIcons.ticket,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SummaryRow(
                        label: "Subtotal:",
                        value: "\$${controller.subtotal.toStringAsFixed(2)}",
                      ),
                      SummaryRow(
                        label: "Delivery Fee:",
                        value: "\$${controller.deliveryFee.toStringAsFixed(2)}",
                      ),
                      SummaryRow(label: "Discount:", value: "0%"),
                      Divider(),
                      SummaryRow(
                        label: "Total:",
                        value: "\$${controller.total.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text:
                        "Checkout for \$${controller.total.toStringAsFixed(2)}",
                    onPressed: () => Get.toNamed(
                      AppRoutes.PAYMENT,
                      arguments: {'total': controller.total},
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              FontAwesomeIcons.cartShopping,
              size: 80,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Looks like you haven't added anything to your cart yet. Go ahead and explore top categories.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: "Explore Products",
            onPressed: () {
              Get.offAllNamed(AppRoutes.HOME);
            },
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: label == 'Total:' ? 20 : 14,
              color: label == 'Total:' ? Colors.black : Colors.grey,
              fontWeight: label == 'Total:'
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: label == 'Total:' ? 20 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
