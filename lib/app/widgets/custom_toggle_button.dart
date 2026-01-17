import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class CustomToggleButton extends StatelessWidget {
  final bool isGrid;
  final VoidCallback onTap;

  const CustomToggleButton({
    super.key,
    required this.isGrid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: isGrid
                  ? null
                  : onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: isGrid ? AppColors.primary : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.tableCellsLarge,
                    size: 16,
                    color: isGrid ? AppColors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          Container(width: 1.5, color: Colors.black54),

          Expanded(
            child: GestureDetector(
              onTap: !isGrid ? null : onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: !isGrid ? AppColors.primary : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.listUl,
                    size: 16,
                    color: !isGrid ? AppColors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
