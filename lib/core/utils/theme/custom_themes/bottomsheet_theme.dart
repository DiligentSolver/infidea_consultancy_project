import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/shapes/shapes.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class MYBottomSheetTheme {
  MYBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: MYColors.lightThemeBg,
    modalBackgroundColor: MYColors.lightThemeBg,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: MYAppShapes.roundedAll(MySizes.borderRadiusXl),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: MYColors.darkThemeBg,
    modalBackgroundColor: MYColors.darkThemeBg,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: MYAppShapes.roundedAll(MySizes.borderRadiusXl),
  );
}
