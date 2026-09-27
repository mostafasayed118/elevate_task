import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rate,
    required super.count,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] as Map<String, dynamic>? ?? {};
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      description: (json['description'] as String?) ?? '',
      category: (json['category'] as String?) ?? '',
      image: (json['image'] as String?) ?? '',
      rate: (rating['rate'] as num?)?.toDouble() ?? 0,
      count: (rating['count'] as num?)?.toInt() ?? 0,
    );
  }

  /// Adapter for the fallback API https://dummyjson.com/products
  /// (the task doc itself links to dummyjson for the design image).
  factory ProductModel.fromDummyJson(Map<String, dynamic> json) {
    final images = json['images'] as List<dynamic>?;
    final thumbnail = json['thumbnail'] as String?;
    final firstImage = images?.isNotEmpty == true
        ? images!.first as String
        : thumbnail ?? '';
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      description: (json['description'] as String?) ?? '',
      category: (json['category'] as String?) ?? '',
      image: firstImage,
      rate: (json['rating'] as num?)?.toDouble() ?? 0,
      count: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }
}
