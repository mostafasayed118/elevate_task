import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
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
    // 1) Primary: fakestoreapi.com (required by task)
    try {
      final Response response = await _apiClient.dio.get('/products');
      final data = response.data as List<dynamic>;
      final items = data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (items.isNotEmpty) return items;
    } on DioException {
      // fall through to fallback — do NOT rethrow here
    }

    // 2) Fallback: dummyjson (separate Dio so baseUrl can't interfere)
    try {
      final fallbackDio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'Mozilla/5.0 (Flutter) ElevateTask/1.0',
          },
        ),
      );
      final Response fallback = await fallbackDio.get(
        'https://dummyjson.com/products?limit=30',
      );
      final map = fallback.data as Map<String, dynamic>;
      final list = (map['products'] as List<dynamic>? ?? []);
      final items = list
          .map((e) => ProductModel.fromDummyJson(e as Map<String, dynamic>))
          .toList();
      if (items.isNotEmpty) return items;
    } on DioException {
      // fall through to local bundle
    }

    // 3) Offline bundle: always works, even with no network
    try {
      final raw = await rootBundle.loadString(
        'assets/products_fallback.json',
      );
      final data = jsonDecode(raw) as List<dynamic>;
      final items = data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (items.isNotEmpty) return items;
    } catch (_) {
      // ignore, throw below
    }

    throw Exception(
      'Failed to fetch products from fakestoreapi.com',
    );
  }
}
