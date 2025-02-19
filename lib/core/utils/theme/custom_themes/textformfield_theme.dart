import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class MYTextFormFieldTheme {
  MYTextFormFieldTheme._();

  static  InputDecorationTheme lightInputDecorationTheme= InputDecorationTheme(
      errorMaxLines: 5,
      prefixIconColor: MYColors.iconColor,
      suffixIconColor: MYColors.iconColor,
      labelStyle: MYAppTextStyles.labelLarge(),
      hintStyle: MYAppTextStyles.bodySmall(color: MYColors.inputFieldHintColor),
      errorStyle: MYAppTextStyles.caption(color: MYColors.inputFieldErrorBorderColor),
      floatingLabelStyle:
      MYAppTextStyles.labelSmall(color: MYColors.black,fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 2, color: MYColors.secondaryLightColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.inputFieldErrorBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(color: MYColors.darkSecondaryButtonDisabledColor, width: 1),
      ),
    );

  static InputDecorationTheme darkInputDecorationTheme= InputDecorationTheme(
      errorMaxLines: 5,
      prefixIconColor: MYColors.darkIconColor,
      suffixIconColor: MYColors.darkIconColor,
      labelStyle: MYAppTextStyles.labelLarge(),
      hintStyle: MYAppTextStyles.bodySmall(color: MYColors.darkInputFieldHintColor),
      errorStyle: MYAppTextStyles.caption(color: MYColors.darkInputFieldErrorBorderColor),
      floatingLabelStyle:
      MYAppTextStyles.labelSmall(color: MYColors.white,fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.secondarylighterColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.secondaryLightColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MYColors.darkInputFieldErrorBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(color: MYColors.darkSecondaryButtonDisabledColor, width: 1),
      ),
    );
}
