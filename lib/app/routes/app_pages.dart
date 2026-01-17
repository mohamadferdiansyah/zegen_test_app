import 'package:get/get.dart';
import 'package:zegen_test_app/app/modules/auth/login/login_screen.dart';
import 'package:zegen_test_app/app/modules/auth/register/register_screen.dart';
import 'package:zegen_test_app/app/modules/auth/login/login_binding.dart';
import 'package:zegen_test_app/app/modules/auth/register/register_binding.dart';
import 'package:zegen_test_app/app/modules/cart/cart_binding.dart';
import 'package:zegen_test_app/app/modules/cart/cart_screen.dart';
import 'package:zegen_test_app/app/modules/checkout/payment/payment_binding.dart';
import 'package:zegen_test_app/app/modules/checkout/payment/payment_screen.dart';
import 'package:zegen_test_app/app/modules/checkout/status/status_screen.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_binding.dart';
import 'package:zegen_test_app/app/modules/product/product_favourite/product_favourite_screen.dart';
import 'package:zegen_test_app/app/modules/product/product_list/product_list_binding.dart';
import 'package:zegen_test_app/app/modules/product/product_list/product_list_screen.dart';
import 'package:zegen_test_app/app/modules/root/root_binding.dart';
import 'package:zegen_test_app/app/modules/root/root_screen.dart';
import 'package:zegen_test_app/app/modules/splash/splash_screen.dart';
import 'package:zegen_test_app/app/modules/splash/splash_binding.dart';
import 'package:zegen_test_app/app/modules/home/home_screen.dart';
import 'package:zegen_test_app/app/modules/home/home_binding.dart';
import 'package:zegen_test_app/app/modules/product/product_detail/product_detail_screen.dart';
import 'package:zegen_test_app/app/modules/product/product_detail/product_detail_binding.dart';
import 'package:zegen_test_app/app/modules/search/search_screen.dart';
import 'package:zegen_test_app/app/modules/search/search_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final initial = AppRoutes.INITIAL;

  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const RootScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_LIST,
      page: () => const ProductListScreen(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_FAVOURITE,
      page: () => const ProductFavouriteScreen(),
      binding: ProductFavouriteBinding(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.PAYMENT,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
    ),
    GetPage(name: AppRoutes.STATUS, page: () => const StatusScreen()),
  ];
}
