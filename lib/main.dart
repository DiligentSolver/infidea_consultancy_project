import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:infidea_consultancy_app/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // Ensure widget binding is initialized
  // Preserve splash screen while loading data
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Get.isDarkMode ? MYAppSystemChrome.setChromeDarkUI():MYAppSystemChrome.setChromeLightUI();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  final AuthRepository authRepository =  AuthRepository();

  runApp(MyApp(isFirstLaunch: isFirstLaunch, authRepository: authRepository,));
}
