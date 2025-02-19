import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/device_utils/device_utility.dart';

class MYElevatedButton extends StatelessWidget {

  final void Function()? onPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? backgroundColor;

  const MYElevatedButton({
    super.key, this.onPressed, this.child, this.width, this.elevation, this.height, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MyAppDeviceUtils.getScreenWidth(context);

    return SizedBox(
      height: height,
      width: width??screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: child
      ),
    );
  }
}