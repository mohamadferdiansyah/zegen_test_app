import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/product_model.dart';
import 'package:zegen_test_app/app/services/api_service.dart';
import 'package:zegen_test_app/app/modules/home/home_controller.dart';

class ProductListController extends GetxController {
  var isGridView = true.obs;

  var products = <ProductModel>[].obs;
  final List<ProductModel> _allProducts = [];
  var isLoading = false.obs;
  var query = ''.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    query.value = (args != null && args['query'] != null)
        ? args['query'].toString()
        : '';
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      List<ProductModel> list = [];
      if (Get.isRegistered<HomeController>()) {
        list = Get.find<HomeController>().products;
      } else {
        list = await ApiService.instance.fetchAllProducts();
      }
      _allProducts
        ..clear()
        ..addAll(list);
      _applyQuery();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  void _applyQuery() {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) {
      products.assignAll(_allProducts);
    } else {
      products.assignAll(
        _allProducts.where((p) {
          return p.title.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q) ||
              p.priceString.contains(q);
        }).toList(),
      );
    }
  }

  void search(String q) {
    query.value = q;
    _applyQuery();
  }
}
