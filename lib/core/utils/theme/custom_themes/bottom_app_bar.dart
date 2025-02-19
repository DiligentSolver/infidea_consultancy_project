import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class MYBottomAppBarTheme {
  MYBottomAppBarTheme._();

  static BottomAppBarTheme lightBottomAppBarTheme =  BottomAppBarTheme(
    height: MySizes.buttonHeightSm*2.r,
    color: MYColors.transparent,
    elevation: 0,
    surfaceTintColor: MYColors.transparent,
  );

  static BottomAppBarTheme darkBottomAppBarTheme =  BottomAppBarTheme(
    height: MySizes.buttonHeightSm*2.r,
    color: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
  );
}
