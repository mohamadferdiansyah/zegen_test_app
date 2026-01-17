import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zegen_test_app/app/models/cart_model.dart';

class CartController extends GetxController {
  var items = <CartModel>[].obs;

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity.value));
  double get deliveryFee => 5.0;
  double get discountPercentage => 0.4;
  double get total => (subtotal + deliveryFee);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity.value);

  CartModel _toCartModel(dynamic product) {
    if (product is CartModel) return product;

    String id = '';
    String category = '';
    String name = '';
    String image = '';
    double price = 0.0;

    if (product is Map) {
      id = (product['id'] ?? product['ID'] ?? product['sku'] ?? '').toString();
      name = (product['title'] ?? product['name'] ?? '').toString();
      category = (product['category'] ?? '').toString();
      image = (product['image'] ?? '').toString();
      final priceRaw = product['price'];
      if (priceRaw is num) {
        price = priceRaw.toDouble();
      } else {
        price = double.tryParse(priceRaw?.toString() ?? '') ?? 0.0;
      }
    } else {
      final s =
          product?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString();
      id = s.hashCode.toString();
      name = s;
    }

    if (id.isEmpty) {
      id = (name + '|' + image).hashCode.toString();
    }

    return CartModel(
      id: id,
      name: name.isNotEmpty ? name : 'Product',
      category: category,
      image: image,
      price: price,
    );
  }

  void addItem(dynamic product) {
    final CartModel cm = _toCartModel(product);
    final idx = items.indexWhere((e) => e.id == cm.id);
    if (idx == -1) {
      items.insert(0, cm);
    } else {
      items[idx].quantity.value++;
    }
  }

  void removeItemById(String id) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx != -1) items.removeAt(idx);
  }

  void increaseQty(int index) => items[index].quantity.value++;
  void decreaseQty(int index) {
    if (items[index].quantity.value > 1) items[index].quantity.value--;
  }

  void removeItem(int index) => items.removeAt(index);
}
