import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_products.dart';
import 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._getProducts) : super(const ProductsState());

  final GetProducts _getProducts;

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading, errorMessage: ''));
    try {
      final products = await _getProducts();
      emit(
        state.copyWith(status: ProductsStatus.success, products: products),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage:
              'No connection to the server. Check your internet and tap Retry.\n(${e.type.name})',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: 'Something went wrong. Please tap Retry.',
        ),
      );
    }
  }

  void search(String query) {
    emit(state.copyWith(query: query));
  }

  Future<void> refresh() => loadProducts();
}
