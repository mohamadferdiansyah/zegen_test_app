import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/product_model.dart';
import 'package:zegen_test_app/app/services/api_service.dart';

class HomeController extends GetxController {
  var isGridView = true.obs;

  var products = <ProductModel>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;

  var selectedCategory = 'All'.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      final list = await ApiService.instance.fetchAllProducts();
      products.assignAll(list);
      categories.assignAll([
        'All',
        "men's clothing",
        'jewelery',
        'electronics',
        "women's clothing",
      ]);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  List<ProductModel> get filteredProducts {
    final sel = selectedCategory.value;
    if (sel == 'All') return products;
    return products.where((p) => p.category == sel).toList();
  }

  void selectCategory(String c) {
    selectedCategory.value = c;
  }
}
