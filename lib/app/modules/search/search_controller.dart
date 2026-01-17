import 'package:get/get.dart';
import 'package:zegen_test_app/app/routes/app_routes.dart';

class SearchPageController extends GetxController {
  var searchQuery = "".obs;

  var searchHistory = <String>[].obs;

  final List<String> trendingKeywords = [
    "Electronics",
    "Gaming",
    "Accessories",
    "Apple",
    "Sale",
  ];

  void clearHistory() => searchHistory.clear();

  void removeHistoryItem(int index) => searchHistory.removeAt(index);

  void submitSearch(String query) {
    final q = query.trim();
    if (q.isEmpty) return;

    searchHistory.removeWhere((e) => e.toLowerCase() == q.toLowerCase());
    searchHistory.insert(0, q);
    if (searchHistory.length > 8) {
      searchHistory.removeRange(8, searchHistory.length);
    }

    Get.toNamed(AppRoutes.PRODUCT_LIST, arguments: {'query': q});
  }
}
