import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/images.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
    MyImages.onBoardingPage1,
      MyImages.onBoardingPage2,
      MyImages.onBoardingPage3,
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: banners.map((banner) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(banner, fit: BoxFit.cover),
        );
      }).toList(),
    );
  }
}
