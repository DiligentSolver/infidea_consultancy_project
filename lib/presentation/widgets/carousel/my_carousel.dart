import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';

class MyCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final double aspectRatio;
  final double viewportFraction;

  const MyCarousel({
    super.key,
    required this.images,
    required this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
  });

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: widget.height,
                autoPlay: true,
                aspectRatio: widget.aspectRatio,
                viewportFraction: widget.viewportFraction,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: widget.images.map((url) {
                return Container(
                  decoration: BoxDecoration(
                    color: MYColors.grey,
                    image: DecorationImage(
                      image: AssetImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            _buildIndicator(),
          ],
        ),
      ],
    );
  }

  // Custom indicator
  Widget _buildIndicator() {
    return Positioned(
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.images.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = entry.key;
              });
            },
            child: _indicatorDot(isSelected: _currentIndex == entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _indicatorDot({required bool isSelected}) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? MYColors.primaryDarkerColor : MYColors.primarylighterColor,
      ),
    );
  }
}
