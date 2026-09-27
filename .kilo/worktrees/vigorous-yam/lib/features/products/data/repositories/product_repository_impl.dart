import 'package:injectable/injectable.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() => _remoteDataSource.fetchProducts();
}
