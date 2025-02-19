import 'package:flutter/material.dart';
import '../../constants/colors.dart';


  class MYProgressIndicatorTheme {
  MYProgressIndicatorTheme._();

  ///--- Customizable Light Progress Indicator Theme
  static ProgressIndicatorThemeData lightProgressIndicatorTheme = ProgressIndicatorThemeData(
  color: MYColors.secondaryLightColor, // Color of the progress indicator
  linearTrackColor: MYColors.grey.withOpacity(0.5), // Track color for linear indicator
  circularTrackColor: MYColors.grey.withOpacity(0.5), // Track color for circular indicator
  );

  ///--- Customizable Dark Progress Indicator Theme
  static ProgressIndicatorThemeData darkProgressIndicatorTheme = ProgressIndicatorThemeData(
  color: MYColors.secondaryLightColor, // Color of the progress indicator
  linearTrackColor: MYColors.white.withOpacity(0.5), // Track color for linear indicator
  circularTrackColor: MYColors.white.withOpacity(0.5), // Track color for circular indicator
  );
  }
