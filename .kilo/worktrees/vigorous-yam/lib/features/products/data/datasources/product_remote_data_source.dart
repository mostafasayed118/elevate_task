import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<ProductModel>> fetchProducts() async {
    // Primary source required by the task.
    try {
      final Response response = await _apiClient.dio.get('/products');
      final data = response.data as List<dynamic>;
      final items = data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (items.isNotEmpty) return items;
    } on DioException {
      // Fall through to the mirror below (fakestoreapi is often down:
      // "Connection reset by peer").
    }

    // Fallback mirror (also referenced in the task doc).
    final Response fallback = await _apiClient.dio.get(
      'https://dummyjson.com/products?limit=30',
    );
    final map = fallback.data as Map<String, dynamic>;
    final list = (map['products'] as List<dynamic>? ?? []);
    return list
        .map((e) => ProductModel.fromDummyJson(e as Map<String, dynamic>))
        .toList();
  }
}
