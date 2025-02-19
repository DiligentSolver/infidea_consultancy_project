import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../shapes/shapes.dart';



class MYCheckBoxTheme {
  MYCheckBoxTheme._();

  ///--- Customizable Light Text Theme
  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
    shape: MYAppShapes.roundedAll(MySizes.borderRadiusSm),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.white;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.secondaryColor;
      } else {
        return MYColors.transparent;
      }
    }),
  );

  ///--- Customizable Dark Text Theme
  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
    shape: MYAppShapes.roundedAll(MySizes.borderRadiusSm),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.white;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MYColors.secondaryColor;
      } else {
        return MYColors.transparent;
      }
    }),
  );
}
