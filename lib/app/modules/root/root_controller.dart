import 'package:get/get.dart';

class RootController extends GetxController {
  var selectedIndex = 0.obs;
  void changeIndex(int i) => selectedIndex.value = i;
}