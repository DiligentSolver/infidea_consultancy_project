import 'package:flutter/services.dart';

import '../../constants/colors.dart';

class MYAppSystemChrome{

  static setChromeLightUI() {
    return SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: MYColors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark,  // Light icons for nav bar
      systemNavigationBarColor: MYColors.transparent, // Transparent Navigation bar
      systemNavigationBarIconBrightness: Brightness.dark, // Light icons for nav bar
    ));
  }

  static setChromeDarkUI() {
    return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MYColors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.light,  // Light icons for nav bar
      systemNavigationBarColor: MYColors.transparent, // Transparent Navigation bar
      systemNavigationBarIconBrightness:Brightness.light, // Light icons for nav bar
    ));
  }

}
