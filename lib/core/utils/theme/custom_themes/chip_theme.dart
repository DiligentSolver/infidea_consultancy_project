import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import '../../constants/colors.dart';

class MYChipTheme {
  MYChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    elevation: MySizes.elevationXl,
    disabledColor: MYColors.iconDisabledColor,
    side: const BorderSide(color: MYColors.secondarylighterColor),
    backgroundColor: MYColors.white,
    labelStyle: MYAppTextStyles.labelMedium(color: MYColors.textPrimaryColor),
    secondaryLabelStyle: MYAppTextStyles.labelMedium(color: MYColors.white),
    selectedColor: MYColors.secondaryLightColor,
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    checkmarkColor: MYColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusXxl), // Adjust the radius here
    ),
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    elevation: MySizes.elevationXl,
    disabledColor: Colors.grey.withOpacity(0.4),
    side: const BorderSide(color: MYColors.secondarylighterColor),
    labelStyle:
        MYAppTextStyles.labelMedium(color: MYColors.darkTextPrimaryColor),
    secondaryLabelStyle: MYAppTextStyles.labelMedium(color: MYColors.white),
    selectedColor: MYColors.secondaryLightColor,
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    checkmarkColor: MYColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusXxl), // Adjust the radius here
    ),
  );
}
