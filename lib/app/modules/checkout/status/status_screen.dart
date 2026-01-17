import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/widgets/custom_button.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final double total = args != null && args['total'] != null
        ? (args['total'] as num).toDouble()
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Your order has been placed successfully.\nWe will notify you when it ships.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _rowSummary(
                    "Transaction ID",
                    "#TRS-${(DateTime.now().millisecondsSinceEpoch % 1000000).toString().padLeft(6, '0')}",
                  ),
                  const Divider(height: 20),
                  _rowSummary("Total Amount", "\$${total.toStringAsFixed(2)}"),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "Back to Home",
              onPressed: () => Get.offAllNamed(AppRoutes.HOME),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowSummary(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
