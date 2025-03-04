// Success Stories Carousel
import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SuccessStoriesCarousel extends StatefulWidget {
  final List<String> imageUrls;
  const SuccessStoriesCarousel({super.key, required this.imageUrls});

  @override
  State<SuccessStoriesCarousel> createState() => _SuccessStoriesCarouselState();
}

class _SuccessStoriesCarouselState extends State<SuccessStoriesCarousel> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey<int>(_currentIndex),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4), // Shadow of secondary color
                    blurRadius: 10, // Softness of the shadow
                    spreadRadius: 3, // How much the shadow spreads
                    offset: const Offset(0, 4), // Offset in X and Y direction
                  ),
                ],
              ),
              child: Image.network(
                widget.imageUrls[_currentIndex],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: widget.imageUrls.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}