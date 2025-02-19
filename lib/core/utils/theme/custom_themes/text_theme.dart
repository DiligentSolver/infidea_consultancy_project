import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class MYTextTheme {
  MYTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: MySizes.displayLarge.r, fontWeight: FontWeight.bold, color: MYColors.textPrimaryColor),
    displayMedium: GoogleFonts.montserrat(
        fontSize: MySizes.displayMedium.r, fontWeight: FontWeight.w500, color: MYColors.textPrimaryColor),
    displaySmall: GoogleFonts.montserrat(
        fontSize: MySizes.displaySmall.r, fontWeight: FontWeight.w300, color: MYColors.textPrimaryColor),
    headlineLarge: GoogleFonts.montserrat(
        fontSize: MySizes.headlineLarge.r, fontWeight: FontWeight.w800, color: MYColors.textPrimaryColor),
    headlineMedium: GoogleFonts.montserrat(
        fontSize: MySizes.headlineMedium.r, fontWeight: FontWeight.w700, color: MYColors.textPrimaryColor),
    headlineSmall: GoogleFonts.montserrat(
        fontSize: MySizes.headlineSmall.r, fontWeight: FontWeight.normal, color: MYColors.textPrimaryColor),
    titleLarge: GoogleFonts.montserrat(
        fontSize: MySizes.titleLarge.r, fontWeight: FontWeight.w500, color: MYColors.textPrimaryColor),
    titleMedium: GoogleFonts.montserrat(
        fontSize: MySizes.titleMedium.r,
        fontWeight: FontWeight.normal,
        color: MYColors.textPrimaryColor),
    titleSmall: GoogleFonts.montserrat(fontSize: MySizes.titleSmall.r, color: MYColors.textPrimaryColor),
    bodyLarge: GoogleFonts.montserrat(
        fontSize: MySizes.bodyLarge.r, color: MYColors.textSecondaryColor),
    bodyMedium: GoogleFonts.montserrat(
        fontSize: MySizes.bodyMedium.r, color: MYColors.textSecondaryColor),
    bodySmall: GoogleFonts.montserrat(fontSize: MySizes.bodySmall.r, color: MYColors.textSecondaryColor),
    // Added label styles
    labelLarge: GoogleFonts.montserrat(
        fontSize: MySizes.labelLarge.r, fontWeight: FontWeight.bold, color: MYColors.textPrimaryColor),
    labelMedium: GoogleFonts.montserrat(
        fontSize: MySizes.labelMedium.r, fontWeight: FontWeight.w500, color: MYColors.textPrimaryColor),
    labelSmall: GoogleFonts.montserrat(
        fontSize: MySizes.labelSmall.r, fontWeight: FontWeight.w300, color: MYColors.textPrimaryColor),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: MySizes.displayLarge.r, fontWeight: FontWeight.bold, color: MYColors.darkTextPrimaryColor),
    displayMedium: GoogleFonts.montserrat(
        fontSize: MySizes.displayMedium.r, fontWeight: FontWeight.w500, color: MYColors.darkTextPrimaryColor),
    displaySmall: GoogleFonts.montserrat(
        fontSize: MySizes.displaySmall.r, fontWeight: FontWeight.w300, color: MYColors.darkTextPrimaryColor),
    headlineLarge: GoogleFonts.montserrat(
        fontSize: MySizes.headlineLarge.r, fontWeight: FontWeight.w800, color: MYColors.darkTextPrimaryColor),
    headlineMedium: GoogleFonts.montserrat(
        fontSize: MySizes.headlineMedium.r, fontWeight: FontWeight.w700, color: MYColors.darkTextPrimaryColor),
    headlineSmall: GoogleFonts.montserrat(
        fontSize: MySizes.headlineSmall.r, fontWeight: FontWeight.normal, color: MYColors.darkTextPrimaryColor),
    titleLarge: GoogleFonts.montserrat(
        fontSize: MySizes.titleLarge.r, fontWeight: FontWeight.w500, color: MYColors.darkTextPrimaryColor),
    titleMedium: GoogleFonts.montserrat(
        fontSize: MySizes.titleMedium.r,
        fontWeight: FontWeight.normal,
        color: MYColors.darkTextPrimaryColor),
    titleSmall: GoogleFonts.montserrat(fontSize: MySizes.titleSmall.r, color: MYColors.darkTextPrimaryColor),
    bodyLarge: GoogleFonts.montserrat(
        fontSize: MySizes.bodyLarge.r, color: MYColors.darkTextSecondaryColor),
    bodyMedium: GoogleFonts.montserrat(
        fontSize: MySizes.bodyMedium.r, color: MYColors.darkTextSecondaryColor),
    bodySmall: GoogleFonts.montserrat(fontSize: MySizes.bodySmall.r, color: Colors.grey),
    // Added label styles
    labelLarge: GoogleFonts.montserrat(
        fontSize: MySizes.labelLarge.r, fontWeight: FontWeight.bold, color: MYColors.darkTextPrimaryColor),
    labelMedium: GoogleFonts.montserrat(
        fontSize: MySizes.labelMedium.r, fontWeight: FontWeight.w500, color: MYColors.darkTextPrimaryColor),
    labelSmall: GoogleFonts.montserrat(
        fontSize: MySizes.labelSmall.r, fontWeight: FontWeight.w300, color: MYColors.darkTextPrimaryColor),
  );
}
