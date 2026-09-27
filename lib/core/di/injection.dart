import 'package:get_it/get_it.dart';

import '../../core/api/api_client.dart';
import '../../features/products/data/datasources/product_remote_data_source.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products.dart';
import '../../features/products/presentation/cubit/products_cubit.dart';

/// Service locator
final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<ApiClient>(ApiClient.new);
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<ProductRemoteDataSource>()),
  );
  getIt.registerFactory<GetProducts>(
    () => GetProducts(getIt<ProductRepository>()),
  );
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(getIt<GetProducts>()),
  );
}
