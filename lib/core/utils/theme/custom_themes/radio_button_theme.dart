import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class MYRadioButtonTheme {
  MYRadioButtonTheme._();

  ///--- Customizable Light Radio Button Theme
  static RadioThemeData lightRadioButtonTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.secondaryLightColor; // Color when selected
      } else {
        return MYColors.secondarylighterColor; // Default color
      }
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return MYColors.secondaryColor.withOpacity(0.1); // Hover color
      }
      return MYColors.secondarylighterColor;
    }),
    splashRadius: MySizes.sm, // Customize splash radius
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Tap target size
  );

  ///--- Customizable Dark Radio Button Theme
  static RadioThemeData darkRadioButtonTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.secondarylighterColor; // Color when selected
      } else {
        return MYColors.white; // Default color
      }
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return MYColors.secondaryLightColor; // Hover color
      }
      return MYColors.secondarylighterColor;
    }),
    splashRadius: MySizes.sm, // Customize splash radius
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Tap target size
  );
}
