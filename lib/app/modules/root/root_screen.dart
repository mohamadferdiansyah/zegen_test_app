import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/modules/home/home_screen.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_screen.dart';
import 'package:zegen_test_app/app/modules/profile/profile_screen.dart';
import 'package:zegen_test_app/app/modules/search/search_screen.dart';
import 'root_controller.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<RootController>();
    final pages = [const HomeScreen(), const SearchScreen(), const ProductFavouriteScreen(), const ProfileScreen()];
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: c.selectedIndex.value, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: c.selectedIndex.value,
          onTap: c.changeIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          elevation: 5,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidHome, size: 20),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search, size: 20),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart, size: 20),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 20),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
