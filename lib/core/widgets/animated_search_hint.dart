import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/App_colors.dart';

class AnimatedSearchHint extends StatefulWidget {
  const AnimatedSearchHint({super.key});

  @override
  _AnimatedSearchHintState createState() => _AnimatedSearchHintState();
}

class _AnimatedSearchHintState extends State<AnimatedSearchHint> {
  final List<String> titles = ['location', 'experience', 'skills', 'company'];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % titles.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Search jobs by ', // Static text
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5), // Slide up effect
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            titles[_currentIndex], // Only last word animates
            key: ValueKey<String>(titles[_currentIndex]), // Ensures animation triggers
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
