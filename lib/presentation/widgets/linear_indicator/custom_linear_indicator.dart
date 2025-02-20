import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double progress;
  final double minHeight;
  final double borderRadius;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle? textStyle;

  const CustomLinearProgressIndicator({
    super.key,
    required this.progress, // 0.0 to 1.0
    this.minHeight = 8.0,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = MYColors.secondaryLightColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: LinearProgressIndicator(
        minHeight: minHeight,
        value: progress.clamp(0.0, 1.0),
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
      ),
    );
  }
}
