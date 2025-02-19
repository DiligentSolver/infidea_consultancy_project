import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import '../../../../core/utils/constants/sizes.dart';

class MyCircularIcon extends StatelessWidget {
  const MyCircularIcon({
    super.key,
    this.width = 48,
    this.height = 48,
    this.iconSize = MySizes.lg,
    required this.icon,
    this.iconColor = Colors.white,
    this.backgroundColor = MYColors.transparent,
    this.onImageSelected, // Callback function
    this.label = "",
    this.showBorder = false,
    this.padding,
    this.showLabel = false, this.onTap,
  });

  final double? width, height, iconSize;
  final void Function()? onTap;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function(XFile?)? onImageSelected;
  final String label;
  final bool showBorder, showLabel;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: padding ?? const EdgeInsets.all(MySizes.sm),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: showBorder
                  ? Border.all(color: MYColors.grey.withOpacity(0.5), width: 1)
                  : null,
              boxShadow: [
                if (backgroundColor != MYColors.transparent)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
        if (showLabel)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: MYAppTextStyles.bodySmall(),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
