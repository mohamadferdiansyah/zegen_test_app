class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  String get name => title;
  String get priceString => price.toStringAsFixed(2);
  String get ratingString => rating.toString();

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingObj = json['rating'] as Map<String, dynamic>? ?? {};
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0) as double,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: (ratingObj['rate'] is int)
          ? (ratingObj['rate'] as int).toDouble()
          : (ratingObj['rate'] ?? 0.0) as double,
      ratingCount: (ratingObj['count'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {'rate': rating, 'count': ratingCount},
    };
  }
}
