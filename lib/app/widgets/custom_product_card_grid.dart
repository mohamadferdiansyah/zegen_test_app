import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class CustomProductCardGrid extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String rating;
  final String category;
  final String ratingCount;
  final String image;

  const CustomProductCardGrid({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.ratingCount,
    required this.category,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.PRODUCT_DETAIL,
          arguments: {
            'name': name,
            'description': description,
            'price': price,
            'ratingCount': ratingCount,
            'category': category,
            'rating': rating,
            'image': image,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(color: AppColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.orange,
                    size: 14,
                  ),
                  SizedBox(width: 3),
                  Text(
                    rating,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "\$$price",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
