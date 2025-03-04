import 'package:dio/dio.dart';


class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://vce-commerce-production.up.railway.app/', // Updated backend URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  ));

  static Dio get dio => _dio;
}
