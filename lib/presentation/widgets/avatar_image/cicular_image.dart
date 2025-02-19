import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';

class MyCircularImage extends StatelessWidget {
  const MyCircularImage({
    super.key,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding,
    required this.assetImage,
    this.networkImage,
  });

  final BoxFit? fit;
  final AssetImage assetImage;
  final Image? networkImage;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        // If Image background color is null then switch it to light and dark mode color design.
        color: backgroundColor ??
            (MYAppHelperFunctions.isDarkMode(context)
                ? MYColors.black
                : MYColors.white),
        shape: BoxShape.circle,
      ),
      child: Image(
        width: width,
        height: height,
        fit: fit,
        image: isNetworkImage
            ? networkImage as ImageProvider
            : assetImage as ImageProvider,
        color: overlayColor,
      ),
    );
  }
}
