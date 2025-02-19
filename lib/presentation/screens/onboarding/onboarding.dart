import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import '../../../core/utils/constants/images.dart';
import '../../../core/utils/constants/texts.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/carousel/my_carousel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> imageUrls = [
    MyImages.onBoardingPage1,
    MyImages.onBoardingPage2,
    MyImages.onBoardingPage3
  ];
  bool isLastPage = false;



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyCarousel(images: imageUrls, height: 0.6.sh, aspectRatio: 9/16, viewportFraction: 1),
              verticalSpace(MySizes.spaceBtwSectionsLg.r),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30), // Responsive padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MYTexts.onBoardingoneTitle,
                        style: MYAppTextStyles.headlineMedium()),
                    verticalSpace(5.r),
                    Text(MYTexts.onBoardingooneDesc,
                        textAlign: TextAlign.center,
                        style:
                        MYAppTextStyles.bodyLarge()),
                    verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    MYElevatedButton(
                        onPressed: ()  {
                          MYAppHelperFunctions.setBoolValue('isFirstLaunch', false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Start Career Now"),
                            horizontalSpace(10),
                            const Icon(Icons.arrow_forward_rounded),
                          ],
                        )),
                  ],
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }


}
