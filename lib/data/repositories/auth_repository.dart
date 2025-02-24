import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/dio_client.dart';
import '../model/user_model.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token') ?? '';
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
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      await _dio.post('api/auth/resend-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to resend OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while resending OTP');
    }
  }

  Future<void> sendOtp(String mobile) async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      await _dio.post('api/auth/send-otp', data: {'mobile': mobile});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to send OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while sending OTP');
    }
  }

  Future<UserModel?> verifyOtp(String mobile, String otp) async {
    try {
      // Add a delay before calling API
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post('api/auth/user-mobile-login', data: {
        'mobile': mobile,
        'otp': otp,
      });

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      UserModel user = UserModel.fromJson(response.data);
      await saveToken(user.token??'');
      print(getToken());
      return user;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to verify OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while verifying OTP');
    }
    return null;
  }

  // Future<void> resendEmailOtp(String email) async {
  //   try {
  //     await _dio.post('api/auth/resend-otp', data: {'email': email});
  //   } on DioException catch (e) {
  //     _handleDioException(e, 'Failed to resend OTP');
  //   } catch (e) {
  //     throw Exception('An unexpected error occurred while resending OTP');
  //   }
  // }

  Future<void> resendEmailVerifyOtp(String email) async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      await _dio
          .post('api/auth/resend-verify-email-otp', data: {'email': email});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to resend OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while resending OTP');
    }
  }
  //
  // Future<void> sendForgotPasswordOtp(String email) async {
  //   try {
  //     await _dio.post('api/auth/send-otp', data: {'email': email});
  //   } on DioException catch (e) {
  //     _handleDioException(e, 'Failed to send OTP');
  //   } catch (e) {
  //     throw Exception('An unexpected error occurred while sending OTP');
  //   }
  // }

  Future<void> sendVerifyEmailOtp(String email) async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      await _dio.post('api/auth/send-otp', data: {'email': email});
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to send OTP');
    } catch (e) {
      throw Exception('An unexpected error occurred while sending OTP');
    }
  }

  Future<UserModel?> registerNewUser(UserModel userModel) async {
    try {
      // Delay for API call simulation
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post(
        'api/auth/user-register',
        data: userModel,
        options: Options(headers: {"Content-Type": "application/json"}), // Important!
      );

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      UserModel user = UserModel.fromJson(response.data);
      await saveToken(user.token ?? '');

      return user;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to register user');
    } catch (e) {
      throw Exception('An unexpected error occurred while registering user');
    }
    return null;
  }

  Future<UserModel?> registerNewUserForm(Map<String,dynamic> formData) async {
    try {
      // Delay for API call simulation
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post(
        'api/auth/user-register',
        data: jsonEncode(formData));

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      UserModel user = UserModel.fromJson(response.data);
      await saveToken(user.token ?? '');

      return user;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to register user');
    } catch (e) {
      throw Exception('An unexpected error occurred while registering user');
    }
    return null;
  }



  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    try {
      // **Add a delay before calling API**
      final response = await _dio.get(
        'api/users/user-profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to fetch user details');
    } catch (e) {
      throw Exception(
          'An unexpected error occurred while fetching user details');
    }
    return null;
  }

  Future<bool> isServerAvailable() async {
    try {
      final response = await _dio
          .get('api/health-check'); // Replace with your actual health check API
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  // **Send Form Data to API (for registration or updating user data)**
  Future<void> sendFormData(Map<String, dynamic> formData) async {
    try {
      final token = await getToken();
      final response = await _dio.put(
        'api/users/update-user-profile', // Update with actual API endpoint
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

    } on DioException catch (e) {
      _handleDioException(e, 'Failed to send form data');
    } catch (e) {
      throw Exception('An unexpected error occurred while sending form data');
    }
    return;
  }

  // **Get Form Data from API (for pre-filling or restoring form)**
  Future<Object?> getSavedUserData() async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        'api/users/user-profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );


      if (response.data == null || response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response from server");
      }

      return response.data["user"];

    } on DioException catch (e) {
      final result = e.response?.data;
      if (result is Map<String, dynamic> &&
          result.containsKey('code') &&
          result['code'] == 1001) {
        // **Return the user data for new users**
        return result;
      }
    } catch (e) {
      throw Exception('An unexpected error occurred while getting form data');
    }
    return null;
  }

  void _handleDioException(DioException e, String defaultMessage) {
    if (e.response != null) {
      if (e.response?.statusCode == 502) {
        throw Exception('Server Problem');
      }
      if (e.response?.data != null &&
          e.response!.data.containsKey('code') &&
          e.response!.data['code'] == 1001 &&
          e.response!.data.containsKey('user') &&
          e.response!.data['user'] != null) {
        throw e.response!.data;
      }
       debugPrint(e.toString());
      throw Exception(e.response?.data['error'] ?? defaultMessage);
    } else if (e.error is SocketException) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception(e);
    }
  }
}
