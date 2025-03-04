import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../utils/dio_client.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;
  final _storage = const FlutterSecureStorage();
  var emitServer = false;
  var emitInternet = false;

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token'); // Clear token
  }

  Future<void> resendOtp(String mobile) async {
    try {
      await _dio.post('api/auth/resend-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to resend OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while resending OTP');
    }
  }


  Future<void> sendOtp(String mobile) async {
    try {
      await _dio.post('api/auth/send-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to send OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while sending OTP');
    }
  }

  Future<UserModel?> verifyOtp(String mobile, String otp) async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post('api/auth/verify-otp', data: {
        'mobile': mobile,
        'otp': otp,
      });

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      UserModel user = UserModel.fromJson(response.data);
      await saveToken(user.token);

      return user;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to verify OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while verifying OTP');
    }
    return null;
  }
  Future<void> resendNewUserOtp(String mobile) async {
    try {
      await _dio.post('api/auth/new-user-resend-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to resend OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while resending OTP');
    }
  }

  Future<void> sendNewUserOtp(String mobile) async {
    try {
      await _dio.post('api/auth/new-user-send-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to send OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while sending OTP');
    }
  }

  Future<UserModel?> verifyNewUserOtp(String name, String email, String age, String gender, String mobile, String otp ) async {
    try {
      // *Add a delay before calling API*
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post('api/auth/new-user-verify-otp', data: {
        'name' : name,
        'email' : email,
        'age' : age,
        'gender' : gender,
        'mobile': mobile,
        'otp': otp,
      });

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      UserModel user = UserModel.fromJson(response.data);
      await saveToken(user.token);

      return user;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to verify OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while verifying OTP');
    }
    return null;
  }


  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    try {
      final response = await _dio.get(
        'api/users/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint('User details response: ${response.data}');

      if (response.data == null) {
        throw Exception("Null response from server");
      }

      if (response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response format: ${response.data.runtimeType}");
      }

      // Extract the user object from the response
      if (response.data['user'] != null) {
        return response.data['user'] as Map<String, dynamic>;
      } else {
        throw Exception("User data not found in response");
      }
    } on DioException catch (e) {
      debugPrint('DioException in fetchUserDetails: $e');
      _handleDioException(e, 'Failed to fetch user details');
    } catch (e) {
      debugPrint('Unexpected error in fetchUserDetails: $e');
      throw Exception('An unexpected error occurred while fetching user details: $e');
    }
    return null;
  }


  void _handleDioException(DioException e, String defaultMessage) {
    if (e.response != null) {
      emitServer = true;
      if(e.response?.statusCode == 502){
        throw Exception('Server Problem');
      }
      debugPrint(e.toString());
      throw Exception(e.response?.data['message'] ?? defaultMessage);
    } else if (e.error is SocketException) {
      emitInternet = true;
      throw Exception('No Internet Connection');
    } else {
      throw Exception(defaultMessage);
    }
  }
}