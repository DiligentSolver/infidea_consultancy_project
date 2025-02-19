import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../text_styles/text_styles.dart';

class MYDropdownButtonTheme {
  MYDropdownButtonTheme._();

  /// --- Light Theme for DropdownButton
  static DropdownMenuThemeData lightDropdownButtonTheme = DropdownMenuThemeData(
    textStyle: MYAppTextStyles.bodyLarge(color: MYColors.textPrimaryColor),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(MYColors.white),
      elevation: WidgetStateProperty.all(MySizes.elevationMd),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
          side: BorderSide(color: MYColors.secondarylighterColor, width: 1),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MYColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 2, color: MYColors.secondaryLightColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.inputFieldErrorBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(color: MYColors.darkSecondaryButtonDisabledColor, width: 1),
      ),
    ),
  );

  /// --- Dark Theme for DropdownButton
  static DropdownMenuThemeData darkDropdownButtonTheme = DropdownMenuThemeData(
    textStyle: MYAppTextStyles.bodyLarge(color: MYColors.darkTextPrimaryColor),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(MYColors.darkBackgroundColor),
      elevation: WidgetStateProperty.all(MySizes.elevationMd),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
          side: BorderSide(color: MYColors.secondarylighterColor, width: 1),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MYColors.darkBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.secondaryLightColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(width: 1, color: MYColors.darkInputFieldErrorBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: BorderSide(color: MYColors.darkSecondaryButtonDisabledColor, width: 1),
      ),
    ),
  );
}