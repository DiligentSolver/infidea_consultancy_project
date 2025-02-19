import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';

class NoInternetNotifierScreen extends StatefulWidget {
  const NoInternetNotifierScreen({super.key});

  @override
  State<NoInternetNotifierScreen> createState() => _NoInternetNotifierScreenState();
}

class _NoInternetNotifierScreenState extends State<NoInternetNotifierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MYColors.black.withOpacity(0.8),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off,size: MySizes.iconXxl*2,color: MYColors.errorColor,),
              verticalSpace(20),
              Text(
                "No Internet Connection",
                style: MYAppTextStyles.headlineSmall(color: MYColors.white)
              ),
              verticalSpace(10),
              Text(
                "Please check your internet connection and try again.",
                style:  MYAppTextStyles.bodyMedium(color: MYColors.white)
              ),
               verticalSpace(30,)
            ],
          ),
        ),
      ),
    );
  }
}
