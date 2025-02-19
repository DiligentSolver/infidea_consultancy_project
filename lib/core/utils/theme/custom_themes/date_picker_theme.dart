import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../text_styles/text_styles.dart';

class MYDatePickerTheme {
  static DatePickerThemeData get lightTheme {
    return DatePickerThemeData(
      backgroundColor: MYColors.surfaceColor,
      headerBackgroundColor: MYColors.secondaryColor,
      headerForegroundColor: MYColors.white,
      surfaceTintColor: MYColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      dayStyle: MYAppTextStyles.bodyMedium(color: MYColors.textPrimaryColor),
      dayForegroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.darkTextPrimaryColor : MYColors.textPrimaryColor,
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.secondaryColor : MYColors.transparent,
      ),
      todayForegroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.darkTextPrimaryColor : MYColors.textPrimaryColor,
      ),
      yearStyle: MYAppTextStyles.titleMedium(color: MYColors.textPrimaryColor),
      yearForegroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.darkTextPrimaryColor : MYColors.textPrimaryColor,
      ),
    );
  }

  static DatePickerThemeData get darkTheme {
    return DatePickerThemeData(
      backgroundColor: MYColors.darkSurfaceColor,
      headerBackgroundColor: MYColors.secondaryColor,
      headerForegroundColor: MYColors.darkTextPrimaryColor,
      surfaceTintColor: MYColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      dayStyle: MYAppTextStyles.bodyMedium(color: MYColors.darkTextPrimaryColor),
      dayForegroundColor: WidgetStateProperty.all(
        MYColors.darkTextPrimaryColor,
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.secondaryColor : MYColors.transparent,
      ),
      todayForegroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.textPrimaryColor : MYColors.darkTextPrimaryColor,
      ),
      yearStyle: MYAppTextStyles.titleMedium(color: MYColors.darkTextPrimaryColor),
      yearForegroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? MYColors.textPrimaryColor : MYColors.darkTextPrimaryColor,
      ),
    );
  }
}
