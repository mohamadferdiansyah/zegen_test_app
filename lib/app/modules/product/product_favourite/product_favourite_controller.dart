import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/product_model.dart';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/product_model.dart';

class ProductFavouriteController extends GetxController {
  var favoriteItems = <ProductModel>[].obs;

  bool get isEmpty => favoriteItems.isEmpty;

  ProductModel _toProductModel(dynamic item) {
    if (item is ProductModel) return item;

    Map<String, dynamic> json;
    if (item is String) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic>) {
          json = decoded;
        } else {
          json = {'title': item, 'image': ''};
        }
      } catch (_) {
        json = {'title': item, 'image': ''};
      }
    } else if (item is Map) {
      json = Map<String, dynamic>.from(item);
    } else {
      throw ArgumentError(
        'Unsupported item type for wishlist: ${item.runtimeType}',
      );
    }

    final title = (json['title'] ?? json['name'] ?? '').toString();
    final image = (json['image'] ?? '').toString();

    int id = 0;
    final rawId = json['id'];
    if (rawId is int && rawId > 0) {
      id = rawId;
    } else if (rawId is String) {
      id = int.tryParse(rawId) ?? 0;
    }
    if (id == 0) {
      id = (title + '|' + image).hashCode & 0x7fffffff;
    }

    final priceRaw = json['price'];
    final double price = priceRaw is num
        ? priceRaw.toDouble()
        : double.tryParse(priceRaw?.toString() ?? '') ?? 0.0;

    final description = (json['description'] ?? '').toString();
    final category = (json['category'] ?? '').toString();

    double rate = 0.0;
    int count = 0;
    final r = json['rating'];
    if (r is Map) {
      final rateRaw = r['rate'];
      rate = rateRaw is num
          ? rateRaw.toDouble()
          : double.tryParse('$rateRaw') ?? 0.0;
      final cntRaw = r['count'];
      count = cntRaw is int ? cntRaw : int.tryParse('$cntRaw' ?? '') ?? 0;
    } else if (r is num) {
      rate = r.toDouble();
    } else if (r is String) {
      rate = double.tryParse(r) ?? 0.0;
    }

    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rate,
      ratingCount: count,
    );
  }

  bool contains(dynamic item) {
    try {
      final p = _toProductModel(item);
      return favoriteItems.any((e) => e.id == p.id);
    } catch (_) {
      return false;
    }
  }

  void addToWishlist(dynamic item) {
    final p = _toProductModel(item);
    if (favoriteItems.any((e) => e.id == p.id)) return;
    favoriteItems.insert(0, p);
  }

  void removeFromWishlistByItem(dynamic item) {
    final p = _toProductModel(item);
    favoriteItems.removeWhere((e) => e.id == p.id);
  }

  void removeFromWishlistAt(int index) {
    if (index >= 0 && index < favoriteItems.length) {
      favoriteItems.removeAt(index);
    }
  }

  void toggleWishlist(dynamic item) {
    final p = _toProductModel(item);
    if (contains(p)) {
      removeFromWishlistByItem(p);
    } else {
      addToWishlist(p);
    }
  }
}
