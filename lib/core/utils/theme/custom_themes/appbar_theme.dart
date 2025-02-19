import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/system_chrome_theme.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../text_styles/text_styles.dart';



class MYAppBarTheme {
  MYAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: MYColors.transparent,
        surfaceTintColor: MYColors.transparent,
        iconTheme: const IconThemeData(
            color: MYColors.black, size: MySizes.iconMd),
        actionsIconTheme: const IconThemeData(
            color: MYColors.black, size: MySizes.iconMd),
        titleTextStyle: MYAppTextStyles.titleMedium(
            color: MYColors.textPrimaryColor),
    );


  static AppBarTheme darkAppBarTheme= AppBarTheme(
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
            color: MYColors.white, size: MySizes.iconMd),
        actionsIconTheme: const IconThemeData(
            color: MYColors.white, size: MySizes.iconMd),
        titleTextStyle: MYAppTextStyles.titleMedium(
            color: MYColors.darkTextPrimaryColor),
    );
}
