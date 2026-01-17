import 'package:flutter/material.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const CustomChip({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: isActive ? null : Border.all(color: Colors.black54),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.white : AppColors.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
