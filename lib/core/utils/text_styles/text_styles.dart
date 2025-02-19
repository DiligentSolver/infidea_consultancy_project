import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/sizes.dart';

class MYAppTextStyles{
  // Display (Very Large Titles)
  static TextStyle displayLarge({Color? color, FontWeight? fontWeight = FontWeight.bold}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.displayLarge.r, // Material 3 standard
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle displayMedium({Color? color, FontWeight? fontWeight= FontWeight.bold}) {
    return GoogleFonts.montserrat(
        fontSize: MySizes.displayMedium.r,
        fontWeight: fontWeight,
        color: color
    );
  }

  static TextStyle displaySmall({Color? color, FontWeight? fontWeight= FontWeight.bold}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.displaySmall.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Headline (Important Page Titles)
  static TextStyle headlineLarge({Color? color, FontWeight? fontWeight= FontWeight.w700}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.headlineLarge.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle headlineMedium({Color? color, FontWeight? fontWeight= FontWeight.w600}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.headlineMedium.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle headlineSmall({Color? color, FontWeight? fontWeight= FontWeight.w500}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.headlineSmall.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Title (Section Headers)
  static TextStyle titleLarge({Color? color, FontWeight? fontWeight= FontWeight.w600}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.titleLarge.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle titleMedium({Color? color, FontWeight? fontWeight= FontWeight.w500}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.titleMedium.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle titleSmall({Color? color, FontWeight? fontWeight= FontWeight.w500}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.titleSmall.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Body (Regular Text Content)
  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight= FontWeight.w400}) {
    return GoogleFonts.lato(
      fontSize: MySizes.bodyLarge.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight= FontWeight.w400}) {
    return GoogleFonts.lato(
      fontSize: MySizes.bodyMedium.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bodySmall({Color? color, FontWeight? fontWeight= FontWeight.w400}) {
    return GoogleFonts.lato(
      fontSize: MySizes.bodySmall.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Label (Small Elements Like Buttons, Chips)
  static TextStyle labelLarge({Color? color, FontWeight? fontWeight= FontWeight.w600}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.labelLarge.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle labelMedium({Color? color, FontWeight? fontWeight= FontWeight.w500}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.labelMedium.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle labelSmall({Color? color, FontWeight? fontWeight= FontWeight.w500}) {
    return GoogleFonts.montserrat(
      fontSize: MySizes.labelSmall.r,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Caption (Very Small Text)
  static TextStyle caption({Color color = Colors.grey, FontWeight? fontWeight= FontWeight.w400}) {
    return GoogleFonts.lato(
      fontSize: MySizes.caption.r,
      fontWeight: fontWeight,
      color: color,
    );
  }
}