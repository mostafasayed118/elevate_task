import '../../domain/entities/product.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.query = '',
    this.errorMessage = '',
  });

  final ProductsStatus status;
  final List<Product> products;
  final String query;
  final String errorMessage;

  List<Product> get filtered {
    if (query.trim().isEmpty) return products;
    final q = query.toLowerCase();
    return products
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q),
        )
        .toList();
  }

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    String? query,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
