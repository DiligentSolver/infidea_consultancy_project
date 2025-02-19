import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/shapes/shapes.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../text_styles/text_styles.dart';


// ---Light & Dark Elevated Button Themes
class MYElevatedButtonTheme {
  MYElevatedButtonTheme._();

  /// --Light Theme
  static ElevatedButtonThemeData lightElevatedButtonTheme=
   ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: MySizes.cSMd),
    elevation: MySizes.elevationXl,
    foregroundColor: MYColors.secondaryButtonTextColor,
    backgroundColor: MYColors.secondaryButtonColor,
    disabledForegroundColor: MYColors.textDisabledColor,
    disabledBackgroundColor: MYColors.secondaryButtonDisabledColor,
    textStyle: MYAppTextStyles.titleMedium(color: MYColors.secondaryButtonTextColor),
    shape: MYAppShapes.rectangle(radius: MySizes.borderRadiusLg)
  ));

  /// --Dark Theme
  static ElevatedButtonThemeData darkElevatedButtonTheme=
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: MySizes.cSMd),
    elevation: MySizes.elevationXl,
    foregroundColor: MYColors.darkSecondaryButtonTextColor,
    backgroundColor: MYColors.darkSecondaryButtonColor,
    disabledForegroundColor: MYColors.darkTextDisabledColor,
    disabledBackgroundColor: MYColors.darkSecondaryButtonDisabledColor,
        textStyle: MYAppTextStyles.titleMedium(color: MYColors.darkSecondaryButtonTextColor),
          shape: MYAppShapes.rectangle(radius: MySizes.borderRadiusLg)
  ));

}
