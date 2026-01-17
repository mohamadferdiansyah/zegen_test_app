import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class TrendingTag extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const TrendingTag({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class HistoryTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HistoryTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: FaIcon(FontAwesomeIcons.history, color: Colors.grey, size: 18),
      title: Text(title, style: const TextStyle(color: AppColors.text)),
      trailing: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.close,
          size: 16,
          color: Colors.grey,
        ),
        onPressed: onDelete,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
