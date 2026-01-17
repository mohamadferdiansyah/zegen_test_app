import 'package:get/get.dart';

class CartModel {
  final String id;
  final String name;
  final String category;
  final String image;
  final double price;
  var quantity = 1.obs;

  CartModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
  });
}