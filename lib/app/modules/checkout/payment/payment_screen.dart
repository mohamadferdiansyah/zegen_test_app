import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';
import 'package:zegen_test_app/app/widgets/custom_payment.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    final args = Get.arguments as Map<String, dynamic>?;
    final double total = args != null && args['total'] != null 
        ? (args['total'] as num).toDouble() 
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(() => controller.isLoading.value 
          ? const SizedBox()
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.text, size: 20),
              onPressed: () => Get.back(),
            ),
        ),
        title: const Text(
          "Payment Method",
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        return _buildPaymentSelection(controller, total);
      }),
    );
  }

  Widget _buildPaymentSelection(PaymentController controller, double total) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total to pay", style: TextStyle(color: Colors.grey)),
          Text(
            "\$${total.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text(
            "Choose your payment method",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                CustomPayment(
                  title: "Bank Transfer",
                  icon: FontAwesomeIcons.bank,
                  isSelected: controller.selectedMethod.value == "Bank Transfer",
                  onTap: () => controller.selectMethod("Bank Transfer"),
                ),
                CustomPayment(
                  title: "Credit Card",
                  icon: FontAwesomeIcons.creditCard,
                  isSelected: controller.selectedMethod.value == "Credit Card",
                  onTap: () => controller.selectMethod("Credit Card"),
                ),
                CustomPayment(
                  title: "E-Wallet (G-Pay/OVO)",
                  icon: FontAwesomeIcons.wallet,
                  isSelected: controller.selectedMethod.value == "E-Wallet",
                  onTap: () => controller.selectMethod("E-Wallet"),
                ),
              ],
            ),
          ),
          CustomButton(
            text: "Confirm Payment",
            onPressed: () => controller.processPayment(total),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  backgroundColor: AppColors.white,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.shieldHalved,
                size: 40,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            "Processing Payment",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text),
          ),
          const SizedBox(height: 12),
          const Text(
            "Please wait, we are securing\nyour transaction...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 100),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.lock, size: 12, color: Colors.grey),
              SizedBox(width: 8),
              Text("Encrypted & Secure Payment", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}