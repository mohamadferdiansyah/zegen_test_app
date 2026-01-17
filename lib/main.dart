import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:zegen_test_app/app/modules/splash/splash_binding.dart';
import 'package:zegen_test_app/app/routes/app_pages.dart';
import 'package:zegen_test_app/app/services/network_controller.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController(), permanent: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'SFProDisplay',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            surface: AppColors.background, 
          ),

          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primary,
            selectionColor: AppColors.primary.withOpacity(
              0.3,
            ), 
            selectionHandleColor: AppColors.primary,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        initialBinding: SplashBinding(),
      ),
    );
  }
}
