import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Flutter) ElevateTask/1.0',
        },
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
