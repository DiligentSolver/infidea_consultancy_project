import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/bottom_app_bar.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/date_picker_theme.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/progress_indicator_theme.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/radio_button_theme.dart';
import 'package:infidea_consultancy_app/core/utils/theme/custom_themes/search_bar_theme.dart';

import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottomsheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/drop_down_menu_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/textformfield_theme.dart';

class MYAppTheme {
  MYAppTheme._();

  /// Light Theme
  static ThemeData lightTheme=ThemeData(
      useMaterial3: true,
      fontFamily: "GoogleFonts",
      brightness: Brightness.light,
      primaryColor: MYColors.primaryColor,
      appBarTheme: MYAppBarTheme.lightAppBarTheme,
      scaffoldBackgroundColor: MYColors.lightThemeBg,
      textTheme: MYTextTheme.lightTextTheme,
      chipTheme: MYChipTheme.lightChipTheme,
      bottomSheetTheme: MYBottomSheetTheme.lightBottomSheetTheme,
      inputDecorationTheme: MYTextFormFieldTheme.lightInputDecorationTheme,
      elevatedButtonTheme: MYElevatedButtonTheme.lightElevatedButtonTheme,
      checkboxTheme: MYCheckBoxTheme.lightCheckBoxTheme,
      radioTheme: MYRadioButtonTheme.lightRadioButtonTheme,
      progressIndicatorTheme: MYProgressIndicatorTheme.lightProgressIndicatorTheme,
      dropdownMenuTheme: MYDropdownButtonTheme.lightDropdownButtonTheme,
      searchBarTheme: MYSearchBarTheme.lightSearchBarTheme,
      bottomAppBarTheme: MYBottomAppBarTheme.lightBottomAppBarTheme,
      datePickerTheme:MYDatePickerTheme.lightTheme
    );


  /// Dark Theme
  static ThemeData darkTheme=ThemeData(
      useMaterial3: true,
      fontFamily: "GoogleFonts",
      brightness: Brightness.dark,
      primaryColor: MYColors.primaryColor,
      appBarTheme: MYAppBarTheme.darkAppBarTheme,
      scaffoldBackgroundColor: MYColors.darkThemeBg,
      textTheme: MYTextTheme.darkTextTheme,
      chipTheme: MYChipTheme.darkChipTheme,
      bottomSheetTheme: MYBottomSheetTheme.darkBottomSheetTheme,
      inputDecorationTheme: MYTextFormFieldTheme.darkInputDecorationTheme,
      elevatedButtonTheme: MYElevatedButtonTheme.darkElevatedButtonTheme,
      checkboxTheme: MYCheckBoxTheme.darkCheckBoxTheme,
      radioTheme: MYRadioButtonTheme.darkRadioButtonTheme,
    progressIndicatorTheme: MYProgressIndicatorTheme.darkProgressIndicatorTheme,
      dropdownMenuTheme: MYDropdownButtonTheme.darkDropdownButtonTheme,
    searchBarTheme: MYSearchBarTheme.darkSearchBarTheme,
    bottomAppBarTheme:MYBottomAppBarTheme.darkBottomAppBarTheme,
    datePickerTheme: MYDatePickerTheme.darkTheme
    );

}
