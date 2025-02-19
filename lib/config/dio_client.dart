import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://13.232.58.159/', // Replace with your backend URL
    connectTimeout: const Duration(seconds: 5000),
    receiveTimeout: const Duration(seconds: 5000),
    headers: {'Content-Type': 'application/json'},
  ));

  static Dio get dio => _dio;
}
