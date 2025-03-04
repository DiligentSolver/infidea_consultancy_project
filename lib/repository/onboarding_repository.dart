// onboarding_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/dio_client.dart';

class OnboardingRepository {

  Future<void> isFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
  }

  Future<bool> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime')??true;
    return isFirstTime;
  }


  // Future<String?> fetchVideoUrl() async {
  //   try {
  //     final response = await _dio.get('api/onboarding/video');
  //     if (response.statusCode == 200) {
  //       return response.data['videoUrl'];
  //     } else {
  //       throw Exception('Failed to load video');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
