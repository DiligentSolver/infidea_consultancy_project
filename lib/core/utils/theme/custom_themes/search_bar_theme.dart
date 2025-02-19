import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../text_styles/text_styles.dart';

class MYSearchBarTheme {
  MYSearchBarTheme._();

  /// Light Theme for SearchBar
  static SearchBarThemeData lightSearchBarTheme = SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(MYColors.white),
    elevation: WidgetStateProperty.all(MySizes.elevationXl),
    textStyle: WidgetStateProperty.all(
      MYAppTextStyles.bodyLarge(color: MYColors.textPrimaryColor),
    ),
    hintStyle: WidgetStateProperty.all(
      MYAppTextStyles.bodyLarge(color: MYColors.inputFieldHintColor),
    ),
    side: WidgetStateProperty.all(
      const BorderSide(
        width: 1,
        color: MYColors.secondarylighterColor,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      ),
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: MySizes.spaceBtwItems),
    ),
    overlayColor: WidgetStateProperty.all(MYColors.white.withOpacity(0.1)),
    constraints: const BoxConstraints(minHeight: 50),
  );

  /// Dark Theme for SearchBar
  static SearchBarThemeData darkSearchBarTheme = SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(MYColors.darkThemeBg),
    elevation: WidgetStateProperty.all(MySizes.elevationXl),
    textStyle: WidgetStateProperty.all(
      MYAppTextStyles.bodyLarge(color: MYColors.darkTextPrimaryColor),
    ),
    hintStyle: WidgetStateProperty.all(
      MYAppTextStyles.bodyLarge(color: MYColors.darkInputFieldHintColor),
    ),
    side: WidgetStateProperty.all(
      const BorderSide(
        width: 1,
        color: MYColors.secondarylighterColor,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      ),
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: MySizes.spaceBtwItems),
    ),
    overlayColor: WidgetStateProperty.all(MYColors.black.withOpacity(0.1)),
    constraints: const BoxConstraints(minHeight: 50),

  );
}